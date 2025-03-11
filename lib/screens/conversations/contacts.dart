import 'package:chat/values/colors.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Contatos",
                style: TextStyle(fontSize: 22),
              ),
            ),
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
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.button,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      iconSize: 32,
                      icon: const Icon(Icons.person_add),
                    ),
                    Text("Novo Contato", style: TextStyle(fontSize: 16),)
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.button,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      iconSize: 32,
                      icon: const Icon(Icons.group_add),
                    ),
                    Text("Criar Grupo", style: TextStyle(fontSize: 16),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
