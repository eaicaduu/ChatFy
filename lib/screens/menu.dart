import 'package:chat/screens/conversations/conversations.dart';
import 'package:chat/screens/config/config.dart';
import 'package:chat/screens/profile/profile.dart';
import 'package:chat/screens/status/status.dart';
import 'package:flutter/material.dart';

import '../values/colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState()  => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 2;

  final List<Widget> _screens = [
    ConfigScreen(),
    Status(),
    Chat(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: getBackgroundColor(context),
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Configuração"),
          BottomNavigationBarItem(icon: Icon(Icons.auto_mode), label: "Status"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Conversas"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return ConversationsScreen();
  }
}

class Status extends StatelessWidget {
  const Status({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusScreen();
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen();
  }
}
