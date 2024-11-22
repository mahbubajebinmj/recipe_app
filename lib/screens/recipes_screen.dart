import 'package:flutter/material.dart';
import 'package:recipe_app/data/models/recipe.dart';
import 'package:recipe_app/data/models/ingredient.dart';
import 'package:recipe_app/data/repositories/memory_repository.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  _RecipesScreenState createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final MemoryRepository _repository = MemoryRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }

  void _addSampleRecipe() {
    final ingredient1 = Ingredient(name: 'Tomato', quantity: 2);
    final ingredient2 = Ingredient(name: 'Cheese', quantity: 1);
    final recipe = Recipe(
        name: 'Tomato Cheese Salad', ingredients: [ingredient1, ingredient2]);
    _repository.addRecipe(recipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipes')),
      body: StreamBuilder<List<Recipe>>(
        stream: _repository.watchAllRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading recipes'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes found.'));
          } else {
            final recipes = snapshot.data!;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return ListTile(
                  title: Text(recipe.name),
                  subtitle: Text('Ingredients: ${recipe.ingredients.length}'),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSampleRecipe,
        child: const Icon(Icons.add),
      ),
    );
  }
}
