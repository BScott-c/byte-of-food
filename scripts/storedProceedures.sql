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