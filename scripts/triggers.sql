CREATE TRIGGER set_update_timestamp_cookbook
BEFORE UPDATE ON cookbook
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_update_timestamp_cookbook();

CREATE TRIGGER set_update_timestamp_recipe
BEFORE UPDATE ON recipe
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_update_timestamp_recipe();