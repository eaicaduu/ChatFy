import 'package:flutter/material.dart';
import 'package:chat/screens/conversations/modules/contacts_bar.dart';
import 'package:chat/screens/conversations/modules/contacts_list.dart';
import 'package:chat/screens/conversations/modules/contacts_selection.dart';
import '../../values/colors.dart';

class ContactsScreen extends StatefulWidget {
  final List<Map<String, String>> contacts;
  final Map<String, bool> verifiedNumbers;
  final bool isLoading;

  const ContactsScreen({
    super.key,
    required this.contacts,
    required this.verifiedNumbers,
    required this.isLoading,
  });

  @override
  ContactsScreenState createState() => ContactsScreenState();
}

class ContactsScreenState extends State<ContactsScreen> {
  final TextEditingController searchController = TextEditingController();

  void _filterContacts(String query) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var displayedContacts = searchController.text.isEmpty
        ? widget.contacts
        : widget.contacts.where((contact) =>
    contact['name']!.toLowerCase().contains(searchController.text.toLowerCase()) ||
        contact['number']!.contains(searchController.text)).toList();

    displayedContacts.sort((a, b) => a['name']!.compareTo(b['name']!));

    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      body: SafeArea(
        child: Column(
          children: [
            ContactsBar(
              contactCount: widget.contacts.length,
              contactCountFilter: displayedContacts.length,
              searchController: searchController,
              onSearchChanged: _filterContacts,
            ),
            const ContactsSelection(),
            Expanded(
              child: displayedContacts.isEmpty
                  ? const Center(
                child: Text(
                  "Nenhum contato encontrado",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
                  : ContactsList(
                sortedContacts: displayedContacts,
                verifiedNumbers: widget.verifiedNumbers,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
