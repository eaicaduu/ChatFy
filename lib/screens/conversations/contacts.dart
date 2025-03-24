import 'package:chat/screens/conversations/modules/contacts_bar.dart';
import 'package:chat/screens/conversations/modules/contacts_selection.dart';
import 'package:flutter/material.dart';

import '../../values/colors.dart';
import 'modules/contacts_service.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  ContactsScreenState createState() => ContactsScreenState();
}

class ContactsScreenState extends State<ContactsScreen> {
  List<Map<String, String>> contacts = [];
  List<Map<String, String>> filteredContacts = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchContacts();
    searchController.addListener(_filterContacts);
  }

  void fetchContacts() async {
    List<Map<String, String>> result = await ContactService.getContacts();
    if (mounted) {
      setState(() {
        contacts = result;
      });
    }
  }

  void _filterContacts() {
    setState(() {
      String query = searchController.text.toLowerCase();
      filteredContacts = contacts
          .where((contact) =>
      contact['name']!.toLowerCase().contains(query) ||
          contact['number']!.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> sortedContacts = List.from(contacts);
    sortedContacts.sort((a, b) => a['name']!.compareTo(b['name']!));

    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      body: SafeArea(
        child: Column(
          children: [
            ContactsBar(
              contactCount: contacts.length,
              contactCountFilter: filteredContacts.length,
              searchController: searchController,
              onSearchChanged: (query) => _filterContacts(),
            ),
            ContactsSelection(),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: sortedContacts.isEmpty
                    ? const Center(
                    child: CircularProgressIndicator(color: AppColors.global))
                    : ListView.builder(
                  itemCount: sortedContacts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                        sortedContacts[index]['photoUrl'] != null &&
                            sortedContacts[index]['photoUrl']!.isNotEmpty
                            ? NetworkImage(sortedContacts[index]['photoUrl']!)
                            : null,
                        radius: 24,
                        backgroundColor: AppColors.backgroundPhoto,
                        child: sortedContacts[index]['photoUrl'] == null ||
                            sortedContacts[index]['photoUrl']!.isEmpty
                            ? const Icon(Icons.person_rounded, color: Colors.white, size: 40)
                            : null,
                      ),
                      title: Text(sortedContacts[index]['name']!),
                      subtitle: Text(sortedContacts[index]['number']!),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
