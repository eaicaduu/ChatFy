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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            "Editar Perfil",
            style: TextStyle(fontSize: 22),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: const Icon(Icons.close_rounded),
            iconSize: 32,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
