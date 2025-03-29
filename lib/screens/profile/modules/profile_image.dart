import 'package:flutter/material.dart';
import '../../../values/colors.dart';

class ProfileImage extends StatelessWidget {
  final String? photoURL;

  const ProfileImage({super.key, required this.photoURL});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      backgroundColor: Colors.white,
      child: SizedBox(
        width: 100,
        height: 100,
        child: CircleAvatar(
          radius: 46,
          backgroundColor: AppColors.backgroundPhoto,
          backgroundImage: photoURL != null
              ? NetworkImage(photoURL!)
              : null,
          child: photoURL == null
              ? const Icon(Icons.person, size: 76, color: Colors.white,)
              : null,
        ),
      ),
    );
  }
}
