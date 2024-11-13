  import 'package:flutter/material.dart';
  import 'package:cook_n_go/models/recipe.dart';
  import 'package:cook_n_go/repositories/recipe_repository.dart';


  class RecipeProvider with ChangeNotifier {
    final RecipeRepository recipeRepository;

    RecipeProvider(this.recipeRepository);

    List<Recipe> _recipes = [];

    List<Recipe> get recipes => _recipes;

    // Method to fetch recipes and convert them into Map<String, dynamic>
    Future<void> searchRecipes(List<String> selectedIngredients) async {
      // Fetch all recipes first (assuming recipeRepository.getRecipes fetches all recipes)
      List<Recipe> allRecipes = await recipeRepository.getRecipes();

      // Filter recipes based on selected ingredients
      _recipes = allRecipes.where((recipe) {
        // Check if any of the selected ingredients are in the recipe's ingredients
        return recipe.ingredients.any((ingredient) => selectedIngredients.contains(ingredient));
      }).toList();

      notifyListeners();
    }

    List<Map<String, dynamic>> get recipesAsMap {
      return _recipes.map((recipe) => recipe.toMap()).toList();
    }
  }