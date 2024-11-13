import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecipeScreen extends StatefulWidget {
  final Map<String, dynamic> recipe;
  final List<String> userIngredients;

  const RecipeScreen({Key? key, required this.recipe, required this.userIngredients}) : super(key: key);

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}



class _RecipeScreenState extends State<RecipeScreen> {
  late YoutubePlayerController _youtubeController;

   @override
  void initState() {
    super.initState();

    // Extract video ID from the URL in recipe['video']
    String videoId = YoutubePlayer.convertUrlToId(widget.recipe['video']) ?? '';

    // Initialize YouTube Player Controller
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Safe casting of ingredients to List<String> if dynamic types are possible
    List<String> recipeIngredients = widget.recipe['ingredients'] != null 
        ? List<String>.from(widget.recipe['ingredients']) 
        : [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.recipe['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ingredients Needed:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: recipeIngredients.map((ingredient) {
                bool hasIngredient = widget.userIngredients.contains(ingredient);

                return Chip(
                  label: Text(ingredient),
                  backgroundColor: hasIngredient ? Colors.green[200] : Colors.red[200],
                  avatar: Icon(
                    hasIngredient ? Icons.check_circle : Icons.cancel,
                    color: hasIngredient ? Colors.green : Colors.red,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Video Link:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(widget.recipe['video'] ?? 'No instructions available.'),
            const SizedBox(height: 8),
            // Add YouTube video player
            YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
            ),
          ],
          
        ),
      ),
    );
  }
}