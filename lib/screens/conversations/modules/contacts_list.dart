import 'package:flutter/material.dart';

import '../../../values/colors.dart';
import '../../../values/navigate.dart';
import '../chat.dart';

class ContactsList extends StatefulWidget {
  final List<Map<String, String>> sortedContacts;
  final Map<String, bool> verifiedNumbers;

  const ContactsList({super.key, required this.sortedContacts, required this.verifiedNumbers});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: widget.sortedContacts.isEmpty
          ? const Center(
          child: CircularProgressIndicator(color: AppColors.global))
          : ListView.builder(
        itemCount: widget.sortedContacts.length,
        itemBuilder: (context, index) {
          final contact = widget.sortedContacts[index];
          final phoneNumber = contact['number']!;
          final isRegistered = widget.verifiedNumbers[phoneNumber] ?? false;

          return ListTile(
            onTap: isRegistered
                ? () => navigate(
              context,
              ChatScreen(
                id: contact['id']!,
                nome: contact['name']!,
                number: contact['number']!,
                photo: contact['photoUrl']!,
              ),
            )
                : null,
            leading: CircleAvatar(
              backgroundImage: contact['photoUrl'] != null &&
                  contact['photoUrl']!.isNotEmpty
                  ? NetworkImage(contact['photoUrl']!)
                  : null,
              radius: 24,
              backgroundColor: AppColors.backgroundPhoto,
              child: contact['photoUrl'] == null ||
                  contact['photoUrl']!.isEmpty
                  ? const Icon(Icons.person_rounded,
                  color: Colors.white, size: 40)
                  : null,
            ),
            title: Text(
              contact['name']!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(contact['number']!),
            trailing: isRegistered
                ? null
                : Text(
              "Convidar",
              style: TextStyle(color: AppColors.global, fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
