import 'package:cook_n_go/Pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:cook_n_go/Pages/ingredient_selection.dart';

class UserMainpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cook n GO"),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('asset/logoCleared.jpg',
                  width: 200, height: 200, fit: BoxFit.cover),
              const Text(
                "COOK N' GO",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IngredientSearchScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.amber, fixedSize: Size(150, 50)),
                  child: const Text("RECIPE"),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.amber, fixedSize: Size(150, 50)),
                  child: const Text("DELIVERY"),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePage()),
                    );
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.amber, fixedSize: Size(150, 50)),
                  child: const Text("PROFILE"),
                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
