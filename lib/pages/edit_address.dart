import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditAddressPage extends StatelessWidget {
  final TextEditingController _addressController = TextEditingController();

  EditAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit your address:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Handle the save action, e.g., save the edited address to the backend

                // Assuming you have a user ID to identify the user in Firestore
                String userId = 'yourUserId';

                // Update the 'lokasi' field in Firestore
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .update({'lokasi': _addressController.text});

                  // Return the edited 'lokasi' to the previous screen
                  Navigator.pop(context, _addressController.text);
                } catch (e) {
                  // Handle any errors that may occur during the update
                  print("Error updating 'lokasi': $e");
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
