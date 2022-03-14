ALTER TABLE public.Recipe
DROP CONSTRAINT fk_user,
ADD CONSTRAINT fk_user
    FOREIGN KEY (userId)
    REFERENCES userTable(userId)
    ON DELETE CASCADE;

ALTER TABLE public.Cookbook
DROP CONSTRAINT fk_user,
ADD CONSTRAINT fk_user
    FOREIGN KEY (userId)
    REFERENCES userTable(userId)
    ON DELETE CASCADE;

ALTER TABLE public.Involves
DROP CONSTRAINT fk_recipe,
ADD CONSTRAINT fk_recipe
    FOREIGN KEY (recipeId)
    REFERENCES Recipe(recipeId)
    ON DELETE CASCADE;

ALTER TABLE public.Involves
DROP CONSTRAINT fk_equipment,
ADD CONSTRAINT fk_equipment
    FOREIGN KEY (equipmentId)
    REFERENCES Equipment(equipmentId)
    ON DELETE CASCADE;

ALTER TABLE public.Holds
DROP CONSTRAINT fk_cookbook,
ADD CONSTRAINT fk_cookbook
    FOREIGN KEY (cookbookId)
    REFERENCES Cookbook(cookbookId)
    ON DELETE CASCADE;
    
ALTER TABLE public.Holds
DROP CONSTRAINT fk_recipe,
ADD CONSTRAINT fk_recipe
    FOREIGN KEY (recipeId)
    REFERENCES Recipe(recipeId)
    ON DELETE CASCADE;

ALTER TABLE public.Favorites
DROP CONSTRAINT fk_cookbook,
ADD CONSTRAINT fk_cookbook
    FOREIGN KEY (cookbookId)
    REFERENCES Cookbook(cookbookId)
    ON DELETE CASCADE;

ALTER TABLE public.Favorites
DROP CONSTRAINT fk_recipe,
ADD CONSTRAINT fk_recipe
    FOREIGN KEY (recipeId)
    REFERENCES Recipe(recipeId)
    ON DELETE CASCADE;

ALTER TABLE public.Ingredient
DROP CONSTRAINT fk_recipe,
ADD CONSTRAINT fk_recipe
    FOREIGN KEY (recipeId)
    REFERENCES Recipe(recipeId)
    ON DELETE CASCADE;

ALTER TABLE public.Ingredient
DROP CONSTRAINT fk_item,
ADD CONSTRAINT fk_item
    FOREIGN KEY (itemId)
    REFERENCES Item(itemId)
    ON DELETE CASCADE;