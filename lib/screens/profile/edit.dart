import 'package:chat/screens/profile/modules/edit_bar.dart';
import 'package:chat/values/colors.dart';
import 'package:flutter/material.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  ProfileEditState createState() => ProfileEditState();
}

class ProfileEditState extends State<ProfileEdit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _profileImage;

  void _selectProfileImage() {
    setState(() {
      _profileImage = "https://placeimg.com/640/480/people";
    });
  }

  void _saveProfile() {
    String name = _nameController.text;
    String phone = _phoneController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      body: SafeArea(
          child: Column(
        children: [
          EditBar(),
        ],
      )),
    );
  }
}
