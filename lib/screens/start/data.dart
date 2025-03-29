import 'package:chat/screens/menu.dart';
import 'package:chat/values/colors.dart';
import 'package:chat/values/navigate.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'modules/data_module.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  DataScreenState createState() => DataScreenState();
}

class DataScreenState extends State<DataScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
  }

  Future<void> saveUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        String? photoUrl;

        if (imageFile != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('profile_pictures/${user.uid}.jpg');

          await ref.putFile(File(imageFile!.path));
          photoUrl = await ref.getDownloadURL();
        }

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'displayName': nameController.text,
          'instagram': instagramController.text,
          'photoURL': photoUrl,
          'phoneNumber': user.phoneNumber,
        });
        if (mounted) {
          navigateReplacement(context, MenuScreen());
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erro ao salvar dados')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      body: DataModule(
        nameController: nameController,
        instagramController: instagramController,
        pickImage: pickImage,
        saveUserData: saveUserData,
        imageFile: imageFile,
      ),
    );
  }
}
