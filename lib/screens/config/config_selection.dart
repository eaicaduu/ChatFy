import 'package:flutter/material.dart';

import '../../values/navigate.dart';
import 'appearance.dart';

class ConfigSelection extends StatelessWidget {
  const ConfigSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildConfigOption(
                  icon: Icons.devices,
                  text: "Dispositivos",
                  onTap: () {},
                ),
                Divider(),
                _buildConfigOption(
                  icon: Icons.analytics_outlined,
                  text: "Sua Atividade",
                  onTap: () {},
                ),
                Divider(),
                _buildConfigOption(
                  icon: Icons.info_outline_rounded,
                  text: "Ajuda",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildConfigOption(
                  icon: Icons.brightness_6_outlined,
                  text: "Tema e Aparência",
                  onTap: () {
                    navigate(context, AppearanceScreen());
                  },
                ),
                Divider(),
                _buildConfigOption(
                  icon: Icons.notifications_active_outlined,
                  text: "Notificações e Sons",
                  onTap: () {},
                ),
                Divider(),
                _buildConfigOption(
                  icon: Icons.lock_outline,
                  text: "Privacidade e Segurança",
                  onTap: () {},
                ),
                Divider(),
                _buildConfigOption(
                  icon: Icons.cloud_outlined,
                  text: "Dados e Armazenamento",
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildConfigOption({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
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
