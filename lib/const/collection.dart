import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Define collection references using final
final CollectionReference userCollection = _firestore.collection('Users');
final CollectionReference venderCollection = _firestore.collection('Vendor');
final CollectionReference adminCollection = _firestore.collection('Admin');
final CollectionReference recipeCollection = _firestore.collection('Recipes');
