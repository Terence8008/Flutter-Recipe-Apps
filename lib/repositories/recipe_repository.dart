import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_n_go/models/recipe.dart';

class RecipeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Recipe>> getRecipes() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Recipes').get();

      // Map each document to a Recipe object
      List<Recipe> recipes = querySnapshot.docs.map((doc) {
        return Recipe.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      return recipes;
    } catch (e) {
      print('Error fetching recipes: $e');
      return [];
    }
  }
  
  Future<List<Recipe>> fetchRecipes(List<String> ingredients) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Recipes')
          .where('ingredients', arrayContainsAny: ingredients)
          .get();

      return querySnapshot.docs.map((doc) {
        return Recipe.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching recipes: $e");
      return [];
    }
  }
}