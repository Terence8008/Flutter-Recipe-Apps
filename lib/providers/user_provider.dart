import 'package:flutter/material.dart';
import 'package:cook_n_go/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository;

  UserProvider(this._userRepository);

  Future<void> updateUserProfile({
    required String username,
    required String allergy,
    required String address,
    required String? gender,
    required bool isVegan,
  }) async {
    await _userRepository.updateUserProfile(
      username: username,
      allergy: allergy,
      address: address,
      gender: gender,
      isVegan: isVegan,
    );
    notifyListeners();
  }
}
