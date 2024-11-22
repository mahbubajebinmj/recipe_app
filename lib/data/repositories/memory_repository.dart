import 'dart:async';

import 'package:recipe_app/data/models/recipe.dart';
import 'package:recipe_app/data/models/ingredient.dart';
import 'repository.dart';

class MemoryRepository implements Repository {
  final List<Recipe> _recipes = [];
  final List<Ingredient> _ingredients = [];
  final _recipesController = StreamController<List<Recipe>>.broadcast();
  final _ingredientsController = StreamController<List<Ingredient>>.broadcast();

  // Method to add a recipe
  @override
  Future<void> addRecipe(Recipe recipe) async {
    _recipes.add(recipe);
    // After adding a recipe, add the new list to the stream
    _recipesController.sink.add(List.from(_recipes));
  }

  // Method to add an ingredient
  @override
  Future<void> addIngredient(Ingredient ingredient) async {
    _ingredients.add(ingredient);
    // After adding an ingredient, add the new list to the stream
    _ingredientsController.sink.add(List.from(_ingredients));
  }

  // Stream that watches all recipes
  @override
  Stream<List<Recipe>> watchAllRecipes() {
    return _recipesController.stream;
  }

  // Stream that watches all ingredients
  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    return _ingredientsController.stream;
  }

  // To prevent memory leaks, we close the streams when not needed
  void dispose() {
    _recipesController.close();
    _ingredientsController.close();
  }
}
