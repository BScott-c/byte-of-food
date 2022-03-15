-- Get Cookbooks for a single user  where userId = ?
CREATE OR REPLACE VIEW UserCookbooks AS 
SELECT userid, cookbookid, cookbookname, cookbookdescription 
from cookbook;
-- Get Recipes Associated with a single Cookbook  where h.cookbookid = ?
CREATE OR REPLACE VIEW CookbookRecipes AS 
SELECT h.cookbookid, r.recipeid, r.recipename, r.recipedescription, r.isprivate from recipe as r 
FULL JOIN holds as h on r.recipeid = h.recipeid;
-- Get Recipe by recipe id where recipeid = '3'
CREATE OR REPLACE VIEW Recipes AS 
SELECT recipeid, recipename, recipedescription, recipeinstructions, userid 
from recipe;
-- Get Recipe Equipment where i.recipeid = '3'
CREATE OR REPLACE VIEW RecipeEquipment AS
SELECT i.recipeid, e.equipmentname, e.equipmentdescription from equipment as e 
FULL JOIN involves as i on e.equipmentid = i.equipmentid;
-- Get Recipe Ingredients where ing.recipeid = '3'
CREATE OR REPLACE VIEW RecipeIngredients AS
SELECT ing.recipeid, item.itemname, ing.ingredientamount, ing.ingredientmeasurement from ingredient as ing
FULL JOIN item on ing.itemid = item.itemid;
-- Get Favorited Recipes where f.userid = '2'
CREATE OR REPLACE VIEW FavoriteRecipes AS
SELECT f.userid, r.recipeid, r.recipename, r.recipedescription, r.isprivate from recipe as r 
FULL JOIN favorites as f on r.recipeid = f.recipeid;
-- Get Admin Page
CREATE OR REPLACE VIEW AdminPage AS
SELECT userid, userfirstname, userlastname, isadmin from usertable;
-- Get User Admin Status where userid = '2'
CREATE OR REPLACE VIEW AdminStatus AS
SELECT userid, isadmin from usertable;
