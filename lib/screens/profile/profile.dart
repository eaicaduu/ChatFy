import 'package:flutter/material.dart';
import '../../values/colors.dart';
import 'edit.dart';
import 'modules/profile_module.dart';
import 'modules/profile_selection.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: getBackgroundColor(context),
        title: const Text("Perfil"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: getBackgroundColor(context),
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ProfileEdit(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileModule(),
            const SizedBox(height: 32),
            ProfileSelection(),
          ],
        ),
      ),
    );
  }
}
