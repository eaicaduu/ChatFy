
import 'package:chat/screens/conversations/modules/contacts_bar.dart';
import 'package:chat/screens/conversations/modules/contacts_list.dart';
import 'package:chat/screens/conversations/modules/contacts_selection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Map<String, bool> verifiedNumbers = {};
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

      for (var contact in result) {
        checkNumberInFirebase(contact['number']!);
      }
    }
  }

  void checkNumberInFirebase(String phoneNumber) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    if (mounted) {
      setState(() {
        verifiedNumbers[phoneNumber] = snapshot.docs.isNotEmpty;
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
            Expanded(
              child: ContactsList(
                sortedContacts: sortedContacts,
                verifiedNumbers: verifiedNumbers,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
