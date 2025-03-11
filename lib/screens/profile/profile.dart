import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../values/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getBackgroundColor(context),
        title: Text("Perfil"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://placeimg.com/640/480/people"),
            ),
            SizedBox(height: 16),
            Text(
              "ChatFy",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "(51)9 9999-9999",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 32),
            ListTile(
              leading: Icon(FontAwesomeIcons.instagram),
              title: Text("Instagram"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.bookmarks_outlined),
              title: Text("Favoritos"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.verified_outlined),
              title: Text("Premium"),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Sair"),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
