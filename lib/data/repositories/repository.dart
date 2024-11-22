import 'package:recipe_app/data/models/recipe.dart';
import 'package:recipe_app/data/models/ingredient.dart';

abstract class Repository {
  // Methods that return a future
  Future<void> addRecipe(Recipe recipe);
  Future<void> addIngredient(Ingredient ingredient);

  // Methods that return a stream of data
  Stream<List<Recipe>> watchAllRecipes();
  Stream<List<Ingredient>> watchAllIngredients();
}
