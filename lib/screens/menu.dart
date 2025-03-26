import 'package:chat/screens/conversations/conversations.dart';
import 'package:chat/screens/config/config.dart';
import 'package:chat/screens/profile/profile.dart';
import 'package:chat/screens/status/status.dart';
import 'package:flutter/material.dart';

import '../values/colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 2;

  final List<Widget> _screens = [
    ConfigScreen(),
    StatusScreen(),
    ConversationsScreen(),
    ProfileScreen(),
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
        bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    ),
    child:
    BottomNavigationBar(
    currentIndex: _selectedIndex,
    onTap: _onItemTapped,
    selectedItemColor: AppColors.global,
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
    ),
    );
  }
}