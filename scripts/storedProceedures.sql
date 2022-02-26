CREATE OR REPLACE FUNCTION trigger_set_update_timestamp(@rowName varchar)
RETURNS TRIGGER AS $$
BEGIN
  NEW.@rowName = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;