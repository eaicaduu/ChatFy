import 'package:flutter/material.dart';

import '../../../values/colors.dart';
import '../edit.dart';

class ProfileBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const ProfileBar({super.key}) : preferredSize = const Size.fromHeight(56.0);

  @override
  ProfileBarState createState() => ProfileBarState();
}


class ProfileBarState extends State<ProfileBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}

