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
  List<Map<String, String>> filteredContacts = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _filterContacts(String query) {
    setState(() {
      query = query.toLowerCase();
      filteredContacts = widget.contacts
          .where((contact) =>
              contact['name']!.toLowerCase().contains(query) ||
              contact['number']!.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> displayedContacts =
        searchController.text.isEmpty ? widget.contacts : filteredContacts;

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
            ContactsSelection(),
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
