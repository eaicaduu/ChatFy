import 'package:flutter/material.dart';
import '../../../values/colors.dart';
import '../../../values/navigate.dart';
import '../chat.dart';

class ContactsList extends StatelessWidget {
  final Map<String, String> contact;
  final bool isRegistered;

  const ContactsList({super.key, required this.contact, required this.isRegistered});

  @override
  Widget build(BuildContext context) {
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
        backgroundImage: contact['photoUrl'] != null && contact['photoUrl']!.isNotEmpty
            ? NetworkImage(contact['photoUrl']!)
            : null,
        radius: 24,
        backgroundColor: AppColors.backgroundPhoto,
        child: contact['photoUrl'] == null || contact['photoUrl']!.isEmpty
            ? const Icon(Icons.person_rounded, color: Colors.white, size: 40)
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
  }
}
