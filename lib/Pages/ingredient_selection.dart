import 'package:flutter/material.dart';
import 'package:cook_n_go/providers/recipe_provider.dart';
import 'search_result.dart';
import 'package:provider/provider.dart';

void main() => runApp(FoodieApp());

class FoodieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IngredientSearchScreen(),
    );
  }
}

class IngredientSearchScreen extends StatefulWidget {
  @override
  _IngredientSearchScreenState createState() => _IngredientSearchScreenState();
}

class _IngredientSearchScreenState extends State<IngredientSearchScreen> {
  final List<String> vegeImages = [
    'asset/vege1.jpg',
    'asset/vege2.jpg',
    'asset/vege3.jpg',
    'asset/vege4.jpg',
    'asset/vege5.jpg',
    'asset/vege6.jpg',
  ];

  final List<String> meatImages = [
    'asset/meat1.jpg',
    'asset/meat2.jpg',
    'asset/meat3.jpg',
    'asset/meat4.jpg',
    'asset/meat5.jpg',
    'asset/meat6.jpg',
  ];

  final List<String> seasoningImages = [
    'asset/season1.jpg',
    'asset/season2.jpg',
    'asset/season3.jpg',
    'asset/season4.jpg',
    'asset/season5.jpg',
    'asset/season6.jpg',
  ];

  final List<String> vegetableNames = [
    "brocoli",
    "carrot",
    "pumpkin",
    "corn",
    "eggplant",
    "potato",
  ];

  final List<String> meatNames = [
    "chicken",
    "beef",
    "pork",
    "mutton",
    "lamb",
    "turkey",
  ];

  final List<String> seasoningNames = [
    "ginger",
    "black pepper",
    "cinnnamon",
    "curry poweder",
    "salt",
    "basil",
  ];

  // A set to store indices of clicked images
  final Set<int> vegetableClickedIndices = Set();
  final Set<int> meatClickedIndices = Set();
  final Set<int> seasoningClickedIndices = Set();

  List<String> selectedIngredients = [];

  @override
  void initState() {
    super.initState();
     selectedIngredients = []; // Clear ingredients when screen is initialized
  }


  Future<void> searchRecipes() async {
    // Get ingredients based on selected indices
    selectedIngredients
        .addAll(vegetableClickedIndices.map((index) => vegetableNames[index]));
    selectedIngredients
        .addAll(meatClickedIndices.map((index) => meatNames[index]));
    selectedIngredients
        .addAll(seasoningClickedIndices.map((index) => seasoningNames[index]));
    print(selectedIngredients);

    // Use RecipeProvider to fetch recipes
    await Provider.of<RecipeProvider>(context, listen: false)
        .searchRecipes(selectedIngredients);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultScreen(
          recipes:  Provider.of<RecipeProvider>(context, listen: false)
          .recipes
          .map((recipe) => recipe.toMap()) // Convert List<Recipe> to List<Map<String, dynamic>>
          .toList(),
          userIngredients: selectedIngredients,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: const Text("Ingredient Selection"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ingredient',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16),
              _buildIngredientSection(
                  'Vegetables', vegeImages, vegetableClickedIndices,vegetableNames),
              const SizedBox(height: 16),
              _buildIngredientSection('Meat', meatImages, meatClickedIndices, meatNames),
              const SizedBox(height: 16),
              _buildIngredientSection(
                  'Seasoning', seasoningImages, seasoningClickedIndices, seasoningNames),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[200],
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    print("pressed");
                    searchRecipes();
                  }, // Perform search when click
                  child: const Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIngredientSection(String title, List<String> images,
      Set<int> clickedIndices, List<String> ingredientNames) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            bool isHovered = false;

            return StatefulBuilder(
              builder: (context, setState) {
                return MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      isHovered = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      isHovered = false;
                    });
                  },
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (clickedIndices.contains(index)) {
                          clickedIndices.remove(index);
                        } else {
                          clickedIndices.add(index);
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (isHovered)
                          Container(
                            color: Colors.black54, // Semi-transparent overlay
                            alignment: Alignment.center,
                            child: Text(
                              ingredientNames[index], // Display ingredient name
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        if (clickedIndices.contains(index))
                          const Positioned(
                            top: 4,
                            right: 4,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
