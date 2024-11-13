import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cook_n_go/Pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:cook_n_go/providers/auth_provider.dart' as auth;
import 'package:cook_n_go/providers/profile_provider.dart';
import 'package:cook_n_go/providers/user_provider.dart';
import 'package:cook_n_go/providers/recipe_provider.dart';
import 'package:cook_n_go/providers/vendor_provider.dart';
import 'package:cook_n_go/repositories/user_repository.dart';
import 'package:cook_n_go/repositories/vendor_repository.dart';
import 'package:cook_n_go/repositories/auth_repository.dart';
import 'package:cook_n_go/repositories/recipe_repository.dart';
import 'package:cook_n_go/repositories/profile_repo.dart';
import 'package:cook_n_go/Pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Running the app with provider setup
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Providing AuthRepository
        Provider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        // Providing AuthProvider
        ChangeNotifierProvider<auth.AuthProvider>(
          create: (context) =>
              auth.AuthProvider(Provider.of<AuthRepository>(context, listen: false)),
        ),
        Provider<UserRepository>(create: (_) => UserRepository()),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(
            Provider.of<UserRepository>(context, listen: false),
          ),
        ),
        Provider<RecipeRepository>(create: (_) => RecipeRepository()),
        ChangeNotifierProvider<RecipeProvider>(
          create: (context) => RecipeProvider(
            Provider.of<RecipeRepository>(context, listen: false),
          ),
        ),
        Provider<RecipeRepository>(create: (_) => RecipeRepository()),
        ChangeNotifierProvider<RecipeProvider>(
          create: (context) => RecipeProvider(
            Provider.of<RecipeRepository>(context, listen: false),
          ),
        ),
        Provider<ProfileRepository>(create: (_) => ProfileRepository()),
        ChangeNotifierProvider<ProfileProvider>(
          create: (context) => ProfileProvider(
            Provider.of<ProfileRepository>(context, listen: false),
          ),
        ),
        Provider<VendorRepository>(create: (_) => VendorRepository()),
        ChangeNotifierProvider<VendorProvider>(
          create: (context) => VendorProvider(
            Provider.of<VendorRepository>(context, listen: false),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Cook n Go',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<auth.AuthProvider>(
          builder: (context, authProvider, _) {
            // Check the authentication state
            if (authProvider.user != null) {
              // If user is signed in, show MainPage
              return const MainPage(); // MainPage from home_page.dart
            } else {
              // If user is not signed in, show LoginPage
              return LoginPage(onTap: () {
                // Handle navigation to registration page
              });
            }
          },
        ),
      ),
    );
  }
}
