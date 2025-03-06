import 'package:chat/screens/conversations.dart';
import 'package:chat/screens/config.dart';
import 'package:chat/screens/profile.dart';
import 'package:chat/screens/status.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState()  => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 2;

  final List<Widget> _screens = [
    Config(),
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
    return ChatScreen();
  }
}

class Status extends StatelessWidget {
  const Status({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusScreen();
  }
}

class Config extends StatelessWidget {
  const Config({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfigScreen();
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen();
  }
}
