import 'package:chat/screens/profile/modules/profile_selection.dart';
import 'package:chat/values/format.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        return {
          'phoneNumber': user.phoneNumber,
          'displayName': data['displayName'] ?? user.displayName,
          'photoURL': data['photoURL'] ?? user.photoURL,
        };
      }
      return {
        'phoneNumber': user.phoneNumber,
        'displayName': user.displayName,
        'photoURL': user.photoURL,
      };
    }

    return {'phoneNumber': null, 'displayName': null, 'photoURL': null};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String?>>(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        String? phoneNumber = snapshot.data?['phoneNumber'].toString();
        String? formatedPhoneNumber = reformatPhoneNumber(phoneNumber!);
        String? displayName = snapshot.data?['displayName'] ?? "Usuário";
        String? photoURL = snapshot.data?['photoURL'];

        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue,
                      width: 3,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 46,
                    backgroundImage: photoURL != null
                        ? NetworkImage(photoURL)
                        : const AssetImage("assets/images/default_profile.png")
                            as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
              ProfileSelection(phoneNumber: phoneNumber),
            ],
          ),
        );
      },
    );
  }
}
