import 'package:flutter/material.dart';
import 'package:cook_n_go/repositories/profile_repo.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepository _profileRepository = ProfileRepository();
  Map<String, dynamic>? _userData;

  ProfileProvider(ProfileRepository of);

  Map<String, dynamic>? get userData => _userData;

  Future<void> fetchUserData() async {
    _userData = await _profileRepository.getUserData();
    notifyListeners();
  }
}