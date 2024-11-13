import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cook_n_go/providers/vendor_provider.dart';

class VendorProfileUpdatePage extends StatelessWidget {
  const VendorProfileUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final vendorProvider = Provider.of<VendorProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Update Vendor Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Username Field
            TextField(
              controller: vendorProvider.usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Restaurant Name Field
            TextField(
              controller: vendorProvider.restaurantController,
              decoration: InputDecoration(
                labelText: 'Restaurant Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Address Field
            TextField(
              controller: vendorProvider.addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Update Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 176, 141, 225),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () async {
                  await vendorProvider.updateVendorProfile();
                  Navigator.pop(context); // Return to the previous screen after update
                },
                child: const Text(
                  'Update',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}