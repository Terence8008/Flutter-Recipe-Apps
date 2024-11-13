import 'package:flutter/material.dart';
import 'package:cook_n_go/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  String? userRole;
  auth.User? _user;

  auth.User? get user => _user;


  AuthProvider(this._authRepository) {
    _authRepository.authStateChanges.listen((auth.User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> signIn(String email, String password) async {
    final user = await _authRepository.signInWithEmail(email, password);
    if (user != null) {
      userRole = await _authRepository.getUserRole(user.uid);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> signUp(String email, String password, String position, String username) async {
    final user = await _authRepository.signUpWithEmail(email, password, position, username);
    if (user != null) {
      _user = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> signOut() async {
    await _authRepository.logout();
    _user = null;
    notifyListeners();
  }
}