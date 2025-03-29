import 'package:chat/screens/start/modules/data_button.dart';
import 'package:chat/screens/start/modules/data_instagram.dart';
import 'package:chat/screens/start/modules/data_name.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../values/colors.dart';

class DataModule extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController instagramController;
  final Future<void> Function() pickImage;
  final Future<void> Function() saveUserData;
  final XFile? imageFile;

  const DataModule({
    super.key,
    required this.nameController,
    required this.instagramController,
    required this.pickImage,
    required this.saveUserData,
    required this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => pickImage(),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.backgroundPhoto,
                    backgroundImage: imageFile != null
                        ? FileImage(File(imageFile!.path))
                        : null,
                    child: imageFile == null
                        ? const Icon(Icons.camera_alt, size: 50, color: Colors.white,)
                        : null,
                  ),
                ),
                SizedBox(height: 16),
                DataName(nameController: nameController),
                SizedBox(height: 16),
                DataInstagram(instagramController: instagramController),
                SizedBox(height: 24),
              ],
            ),
          ),
          DataButton(saveUserData: saveUserData)
        ],
      ),
    );
  }
}
