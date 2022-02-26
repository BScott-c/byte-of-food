CREATE OR REPLACE FUNCTION trigger_set_update_timestamp_recipe()
RETURNS TRIGGER AS $$
BEGIN
  NEW.recipeUpdatedDate = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION trigger_set_update_timestamp_cookbook()
RETURNS TRIGGER AS $$
BEGIN
  NEW.cookbookUpdatedDate = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- pass in recipeId as id 
CREATE OR REPLACE FUNCTION togglePrivate(id integer)
RETURNS BOOLEAN AS $$
BEGIN
  UPDATE recipe SET isPrivate = NOT isPrivate WHERE recipeId = id;
  RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

-- pass in userId as id
CREATE OR REPLACE FUNCTION toggleAdmin(id integer)
RETURNS BOOLEAN AS $$
BEGIN
  UPDATE userTable SET isAdmin = NOT isAdmin WHERE userId = id;
  RETURN TRUE;
END;
$$ LANGUAGE plpgsql;