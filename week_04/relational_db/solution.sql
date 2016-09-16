CREATE TABLE ingredient (
	ingredient_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	note TEXT
);

CREATE TABLE measurement (
	measurement_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	abbrev TEXT NOT NULL
);

CREATE TABLE practice (
	practice_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	"action" TEXT NOT NULL,
	tool TEXT NOT NULL,
	details TEXT,
	duration_hrs REAL
);

CREATE TABLE recipe (
	recipe_id INTEGER NOT NULL,
	name TEXT NOT NULL,
	step INTEGER NOT NULL,
	practice_id INTEGER NOT NULL,
	ingredient_id INTEGER,
	measurement_id INTEGER,
	amount REAL,
		FOREIGN KEY (practice_id) REFERENCES practice(practice_id),
		FOREIGN KEY (ingredient_id) REFERENCES ingredient(ingredient_id),
		FOREIGN KEY (measurement_id) REFERENCES measurement(measurement_id)
);


INSERT INTO ingredient(name, note)
VALUES
	("cake flour", NULL),
	("sugar", NULL),
	("ightly beaten eggs", NULL),
	("buttermilk", NULL),
	("baking soda", NULL),
	("vanilla extract", NULL),
	("unsalted butter", NULL),
	("unsweetened cocoa powder", NULL),
	("water", NULL),
	("chopped pecans", "toasted optional"),
	("powdered sugar", NULL);

	

INSERT INTO measurement(name, abbrev)
VALUES
	("teaspoon", "tsp"),
	("tablespoon", "Tbsp"),
	("cup", "c"),
	("ounce", "oz"),
	("pint", "pt"),
	("quart", "qt"),
	("gallon", "gal"),
	("pound", "lb"),
	("degrees", "deg");


INSERT INTO practice("action", tool, details, duration_hrs)
VALUES
	("pre-heat", "oven", NULL, NULL),
	("grease", "baking pan", "9-by-13-inch", NULL),
	("combine", "bowl", "large", NULL),
	("stir", "bowl", "medium", NULL),
	("combine", "double boiler", NULL, NULL),
	("melt", "double boiler", NULL, NULL),
	("add", "bowl", "large", NULL),
	("stir", "hand", "until mixed", NULL),
	("pour", "baking pan", NULL, NULL),
	("bake", "oven", "until a toothpick inserted in center comes out clean", 0.66666667),
	("melt", "saucepan", "medium heat", NULL),
	("stir", "saucepan", "until well blended", NULL),
	("add", "saucepan", NULL, NULL),
	("whisk", "saucepan", "until it has a smooth, pourable consistency", NULL);
	
INSERT INTO recipe(recipe_id, name, step, practice_id, ingredient_id, measurement_id, amount)
VALUES
	(1, "1886 Chocolate Cake", 1, 1, NULL, 9, 350),
	(1, "1886 Chocolate Cake", 2, 2, NULL, NULL, NULL),
	(1, "1886 Chocolate Cake", 3, 3, 1, 2, 3),	
	(1, "1886 Chocolate Cake", 3, 3, 2, 2, 3),	
	(1, "1886 Chocolate Cake", 3, 3, 5, 1, 1),	
	(1, "1886 Chocolate Cake", 4, 4, 3, 2, NULL),	
	(1, "1886 Chocolate Cake", 4, 4, 4, 1, 3),	
	(1, "1886 Chocolate Cake", 4, 4, 6, 2, 1),	
	(1, "1886 Chocolate Cake", 5, 5, 7, 3, 1),
	(1, "1886 Chocolate Cake", 5, 5, 8, 3, 0.5),
	(1, "1886 Chocolate Cake", 5, 5, 9, 3, 0.666667),
	(1, "1886 Chocolate Cake", 5, 6, NULL, NULL, NULL),
	(1, "1886 Chocolate Cake", 6, 7, NULL, NULL, NULL),
	(1, "1886 Chocolate Cake", 6, 8, NULL, NULL, NULL),
	(1, "1886 Chocolate Cake", 7, 9, NULL, NULL, NULL),
	(1, "1886 Chocolate Cake", 8, 10, NULL, NULL, NULL),
	(2, "1886 Chocolate Glaze", 1, 11, 7, 3, 0.5),
	(2, "1886 Chocolate Glaze", 2, 12, 8, 3, 0.5),
	(2, "1886 Chocolate Glaze", 2, 12, 6, 1, 1),
	(2, "1886 Chocolate Glaze", 3, 13, 4, 3, 0.25),
	(2, "1886 Chocolate Glaze", 3, 13, 11, 3, 2),
	(2, "1886 Chocolate Glaze", 4, 14, NULL, NULL, NULL);
	
	
CREATE VIEW chocolate_cake
AS
select
recipe.name as recipe,
recipe.step,
practice.action as do,
practice.tool as "with",
practice.details,
ingredient.name as "ingredient",
recipe.amount,
measurement.abbrev as measurement,
practice.duration_hrs
from recipe
left join ingredient on recipe.ingredient_id = ingredient.ingredient_id
left join measurement on recipe.measurement_id = measurement.measurement_id
left join practice on  recipe.practice_id = practice.practice_id
where recipe.name like "1886%Cake"
order by recipe, step

CREATE VIEW chocolate_glaze
AS
select
recipe.name as recipe,
recipe.step,
practice.action as do,
practice.tool as "with",
practice.details,
ingredient.name as "ingredient",
recipe.amount,
measurement.abbrev as measurement,
practice.duration_hrs
from recipe
left join ingredient on recipe.ingredient_id = ingredient.ingredient_id
left join measurement on recipe.measurement_id = measurement.measurement_id
left join practice on  recipe.practice_id = practice.practice_id
where recipe.name like "1886%Glaze"
order by recipe, step


select * from chocolate_cake
union
select * from chocolate_glaze


