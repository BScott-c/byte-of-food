CREATE TABLE userTable
(
  userEmail VARCHAR(1024) NOT NULL,
  userPassword VARCHAR(1024) NOT NULL CONSTRAINT CHK_Password CHECK (userPassword > 8),
  userFirstName VARCHAR(1024) NOT NULL,
  userLastName VARCHAR(1024) NOT NULL,
  userId SERIAL NOT NULL,
  isAdmin BOOLEAN NOT NULL,
  PRIMARY KEY (userId),
  UNIQUE (userEmail)
);

CREATE TABLE Recipe
(
  recipeId SERIAL NOT NULL,
  recipeName VARCHAR(1024) NOT NULL,
  recipeInstructions VARCHAR(1024) NOT NULL,
  isPrivate BOOLEAN NOT NULL,
  recipeDescription VARCHAR(1024),
  recipeUpdatedDate DATE NOT NULL,
  userId INT NOT NULL,
  PRIMARY KEY (recipeId),
  CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES userTable(userId)
);

CREATE TABLE Cookbook
(
  cookbookId SERIAL NOT NULL,
  cookbookName VARCHAR(1024) NOT NULL,
  cookbookDescription VARCHAR(1024),
  cookbookUpdatedDate DATE NOT NULL,
  userId INT NOT NULL,
  PRIMARY KEY (cookbookId),
  CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES userTable(userId)
);

CREATE TABLE Equipment
(
  equipmentName VARCHAR(1024) NOT NULL,
  equipmentId SERIAL NOT NULL,
  equipmentDescription VARCHAR(1024),
  PRIMARY KEY (equipmentId)
);

CREATE TABLE Item
(
  itemId SERIAL NOT NULL,
  itemName VARCHAR(1024) NOT NULL,
  PRIMARY KEY (itemId)
);

CREATE TABLE Involves
(
  recipeId INT NOT NULL,
  equipmentId INT NOT NULL,
  PRIMARY KEY (recipeId, equipmentId),
  CONSTRAINT fk_recipe FOREIGN KEY (recipeId) REFERENCES Recipe(recipeId),
  CONSTRAINT fk_equipment FOREIGN KEY (equipmentId) REFERENCES Equipment(equipmentId)
);

CREATE TABLE Holds
(
  cookbookId INT NOT NULL,
  recipeId INT NOT NULL,
  PRIMARY KEY (cookbookId, recipeId),
  CONSTRAINT fk_cookbook FOREIGN KEY (cookbookId) REFERENCES Cookbook(cookbookId),
  CONSTRAINT fk_recipe FOREIGN KEY (recipeId) REFERENCES Recipe(recipeId)
);

CREATE TABLE Favorites
(
  userId INT NOT NULL,
  recipeId INT NOT NULL,
  PRIMARY KEY (userId, recipeId),
  CONSTRAINT fk_user FOREIGN KEY (userId) REFERENCES userTable(userId),
  CONSTRAINT fk_recipe FOREIGN KEY (recipeId) REFERENCES Recipe(recipeId)
);

CREATE TABLE Ingredient
(
  ingredientId SERIAL NOT NULL,
  ingredientAmount INT NOT NULL,
  ingredientMeasurement VARCHAR(1024) NOT NULL,
  itemId INT NOT NULL,
  recipeId INT NOT NULL,
  PRIMARY KEY (ingredientId, itemId, recipeId),
  CONSTRAINT fk_item FOREIGN KEY (itemId) REFERENCES Item(itemId),
  CONSTRAINT fk_recipe FOREIGN KEY (recipeId) REFERENCES Recipe(recipeId)
);
