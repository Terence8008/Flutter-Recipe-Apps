import 'package:flutter/material.dart';
import 'recipe_detail.dart';

class SearchResultScreen extends StatelessWidget {
  final List<Map<String, dynamic>> recipes;
  final List<String> userIngredients; // List of ingredients user has

  SearchResultScreen({required this.recipes, required this.userIngredients});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Text(
          'RESULT',
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: recipes.isEmpty
            ? const Center(
                child: Text('No recipes found for the selected ingredients'))
            : ListView.builder(
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];
                  return Card(
                    child: ListTile(
                      title: Text(recipe['name']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecipeScreen(
                                    recipe: Map<String, dynamic>.from(
                                        recipe),
                                    userIngredients:
                                        List<String>.from(userIngredients),
                                  )),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
