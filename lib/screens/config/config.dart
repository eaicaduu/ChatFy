import 'package:chat/screens/config/appearance.dart';
import 'package:flutter/material.dart';

import '../../values/colors.dart';

class ConfigScreen extends StatelessWidget {
  const ConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      appBar: AppBar(
          backgroundColor: getBackgroundColor(context),
          title: Text("Configuração"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _buildConfigOption(
                    icon: Icons.devices,
                    text: "Dispositivos",
                    onTap: () {

                    },
                  ),
                  Divider(),
                  _buildConfigOption(
                    icon: Icons.analytics_outlined,
                    text: "Sua Atividade",
                    onTap: () {

                    },
                  ),
                  Divider(),
                  _buildConfigOption(
                    icon: Icons.info_outline_rounded,
                    text: "Ajuda",
                    onTap: () {

                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _buildConfigOption(
                    icon: Icons.brightness_6_outlined,
                    text: "Tema e Aparência",
                    onTap: () {
                      navigateWithSlideTransition(context, AppearanceScreen());
                    },
                  ),
                  Divider(),
                  _buildConfigOption(
                    icon: Icons.notifications_active_outlined,
                    text: "Notificações e Sons",
                    onTap: () {

                    },
                  ),
                  Divider(),
                  _buildConfigOption(
                    icon: Icons.lock_outline,
                    text: "Privacidade e Segurança",
                    onTap: () {

                    },
                  ),
                  Divider(),
                  _buildConfigOption(
                    icon: Icons.cloud_outlined,
                    text: "Dados e Armazenamento",
                    onTap: () {

                    },
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Text("Versão 0.0.01"),
          )
        ],
      ),
    );
  }

  Widget _buildConfigOption({required IconData icon, required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, size: 30),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

void navigateWithSlideTransition(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    ),
  );
}
