-- Setup JWT generation
CREATE EXTENSION IF NOT EXISTS pgcrypto;

DROP TYPE IF EXISTS jwt_token CASCADE;
CREATE TYPE jwt_token AS (
  token text
);

CREATE OR REPLACE FUNCTION url_encode(data bytea) RETURNS text LANGUAGE sql AS $$
    SELECT translate(encode(data, 'base64'), E'+/=\n', '-_');
$$;

CREATE OR REPLACE FUNCTION algorithm_sign(signables text, secret text, algorithm text)
RETURNS text LANGUAGE sql AS $$
WITH
  alg AS (
    SELECT CASE
      WHEN algorithm = 'HS256' THEN 'sha256'
      WHEN algorithm = 'HS384' THEN 'sha384'
      WHEN algorithm = 'HS512' THEN 'sha512'
      ELSE '' END AS id)
SELECT url_encode(hmac(signables, secret, alg.id)) FROM alg;
$$;


CREATE OR REPLACE FUNCTION sign(payload json, secret text, algorithm text DEFAULT 'HS256')
RETURNS text LANGUAGE sql AS $$
WITH
  header AS (
    SELECT url_encode(convert_to('{"alg":"' || algorithm || '","typ":"JWT"}', 'utf8')) AS data
    ),
  payload AS (
    SELECT url_encode(convert_to(payload::text, 'utf8')) AS data
    ),
  signables AS (
    SELECT header.data || '.' || payload.data AS data FROM header, payload
    )
SELECT
    signables.data || '.' ||
    algorithm_sign(signables.data, secret, algorithm) FROM signables;
$$;
--

--

CREATE OR REPLACE FUNCTION
signup(email TEXT, password TEXT, firstName TEXT, lastName TEXT) RETURNS VOID
AS $$
  INSERT INTO userTable (userEmail, userPassword, userFirstName, userLastName, isAdmin) VALUES
    (signup.email, signup.password, signup.firstName, signup.lastName, 'FALSE');
$$ LANGUAGE sql SECURITY DEFINER;

--

CREATE OR REPLACE FUNCTION
login(email TEXT, password TEXT) RETURNS jwt_token
  LANGUAGE plpgsql SECURITY DEFINER
  AS $$
DECLARE
  _role NAME;
  result jwt_token;
BEGIN
  SELECT userTable.userId FROM userTable WHERE userTable.userEmail=login.email AND userTable.userPassword=login.password INTO _role;
  IF _role IS NULL THEN
    RAISE invalid_password USING message = 'invalid user or password';
  END IF;

  SELECT sign(
      row_to_json(r), current_setting('app.settings.jwt_secret')
    ) AS token
    from (
      SELECT 'admins' AS role, login.email AS email, _role AS user_id,
         extract(epoch from now())::integer + 3600*60*60 as exp
    ) r
    INTO result;

  RETURN result;
END;
$$;

--

GRANT EXECUTE ON FUNCTION
  login(text,text),
  signup(text, text, text, text)
  TO anonymous;

