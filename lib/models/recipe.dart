class Recipe {
  final String name;
  final List<String> ingredients;
  final String video;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.video,
  });

  // Add this method to serialize a Recipe to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ingredients': ingredients,
      'video': video,
    };
  }

  // Add a method to create a Recipe object from a map
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      name: map['name'] ?? '',
      ingredients: List<String>.from(map['ingredients'] ?? []),
      video: map['video'] ?? '',
    );
  }
}