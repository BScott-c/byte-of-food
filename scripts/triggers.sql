CREATE TRIGGER set_update_timestamp
BEFORE UPDATE ON cookbook
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_update_timestamp(cookbookUpdatedDate);

CREATE TRIGGER set_update_timestamp
BEFORE UPDATE ON recipe
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_update_timestamp(recipeUpdatedDate);