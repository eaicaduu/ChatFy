
import 'package:chat/screens/profile/logout.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileSelection extends StatelessWidget {
  const ProfileSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(FontAwesomeIcons.instagram),
          title: const Text("Instagram"),
          onTap: () {
            // Lógica para abrir Instagram
          },
        ),
        ListTile(
          leading: const Icon(Icons.bookmarks_outlined),
          title: const Text("Favoritos"),
          onTap: () {
            // Lógica para favoritos
          },
        ),
        ListTile(
          leading: const Icon(Icons.verified_outlined),
          title: const Text("Premium"),
          onTap: () {
            // Lógica para Premium
          },
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text("Sair"),
          onTap: () {
            confirmLogout(context);
          },
        ),
      ],
    );
  }
}
