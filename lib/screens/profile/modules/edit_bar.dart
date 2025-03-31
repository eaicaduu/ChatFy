import 'package:flutter/material.dart';

class EditBar extends StatelessWidget {
  const EditBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: const Icon(Icons.close_rounded),
            iconSize: 32,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            "Editar Perfil",
            style: TextStyle(fontSize: 22),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            "Salvar",
            style: TextStyle(fontSize: 22, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
