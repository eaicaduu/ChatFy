import 'package:chat/screens/profile/modules/profile_bar.dart';
import 'package:flutter/material.dart';
import '../../values/colors.dart';
import 'modules/profile_module.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      appBar: ProfileBar(),
      body: ProfileModule(),
    );
  }
}
