import 'package:flutter/material.dart';

class ContactsBar extends StatelessWidget {
  final int contactCount;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  const ContactsBar({
    super.key,
    required this.contactCount,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$contactCount Contatos",
                style: const TextStyle(fontSize: 22),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                iconSize: 32,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: "Pesquisar contatos...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ],
    );
  }
}
