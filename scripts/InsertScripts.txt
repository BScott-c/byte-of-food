INSERT INTO userTable(userEmail, userPassword, userFirstName, userLastName, isAdmin)
VALUES ('firstUser@test.com', 'strongpassword', 'Test', 'User', '0');

INSERT INTO Recipe (recipeName, recipeInstructions, isPrivate, recipeDescription, recipeUpdatedDate, userId)
VALUES('Awesome Recipe', '1. Mix Cheese 2. Poor Cheese 3. Cook Cheese', '1', 'short recipe description goes here', '1/27/2022', '1');

INSERT INTO Cookbook (cookbookName, cookbookDescription, cookbookUpdatedDate, userId)
VALUES ('Awesome Cookbook', 'some short description for a cookbook', '1/23/22', '1');

INSERT INTO Equipment(equipmentName, equipmentDescription)
VALUES('air fryer', 'my best friend in the kitchen');

INSERT INTO Item (itemName)
VALUES ('kiwi');

INSERT INTO Involves(recipeId, equipmentId)
VALUES ('2', '1');

INSERT INTO Holds(cookbookId, recipeId)
VALUES ('1', '2');

INSERT INTO Favorites(userId, recipeId)
VALUES ('1', '2');

INSERT INTO Ingredient(ingredientAmount, ingredientMeasurement, itemId, recipeId)
VALUES ('2', 'Cups', '1', '2');

