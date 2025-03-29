import 'package:chat/screens/profile/modules/profile_image.dart';
import 'package:chat/screens/profile/modules/profile_selection.dart';
import 'package:chat/values/format.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../database/database.dart';

class ProfileModule extends StatelessWidget {
  const ProfileModule({super.key});

  Future<Map<String, String?>> getUserData() async {
    final databaseHelper = DatabaseHelper();
    String? localPhoneNumber = await databaseHelper.getSession();
    User? user = FirebaseAuth.instance.currentUser;

    if (localPhoneNumber != null) {
      return {'phoneNumber': localPhoneNumber};
    }

    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      String? photoURL = await getProfileImage(user.uid);

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        return {
          'phoneNumber': user.phoneNumber,
          'displayName': data['displayName'] ?? user.displayName,
          'photoURL': photoURL ?? data['photoURL'] ?? user.photoURL,
        };
      }
      return {
        'phoneNumber': user.phoneNumber,
        'displayName': user.displayName,
        'photoURL': photoURL ?? user.photoURL,
      };
    }

    return {'phoneNumber': null, 'displayName': null, 'photoURL': null};
  }

  Future<String?> getProfileImage(String userId) async {
    try {
      final ref = FirebaseStorage.instance.ref().child('profile_pictures/$userId.jpg');
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        String? phoneNumber = snapshot.data?['phoneNumber'];
        String? formatedPhoneNumber = phoneNumber != null ? reformatPhoneNumber(phoneNumber) : '';
        String? displayName = snapshot.data?['displayName'] ?? "Usuário";
        String? photoURL = snapshot.data?['photoURL'];

        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImage(photoURL: photoURL),
              SizedBox(height: 16),
              Text(
                displayName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                formatedPhoneNumber,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              ProfileSelection(phoneNumber: phoneNumber ?? ""),
            ],
          ),
        );
      },
    );
  }
}
