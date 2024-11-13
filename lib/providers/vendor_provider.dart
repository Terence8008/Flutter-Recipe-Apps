import 'package:flutter/material.dart';
import 'package:cook_n_go/repositories/vendor_repository.dart';

class VendorProvider extends ChangeNotifier {
  final VendorRepository _vendorRepository;
  VendorProvider(this._vendorRepository);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController restaurantController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  Future<void> updateVendorProfile() async {
    await _vendorRepository.updateVendorProfile(
      username: usernameController.text,
      restaurant: restaurantController.text,
      address: addressController.text,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    restaurantController.dispose();
    addressController.dispose();
    super.dispose();
  }
}