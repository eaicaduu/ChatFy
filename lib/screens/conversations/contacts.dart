import 'package:flutter/material.dart';
import 'package:chat/screens/conversations/modules/contacts_bar.dart';
import 'package:chat/screens/conversations/modules/contacts_list.dart';
import 'package:chat/screens/conversations/modules/contacts_selection.dart';
import '../../database/firebase/contacts_service.dart';
import '../../values/colors.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  ContactsScreenState createState() => ContactsScreenState();
}

class ContactsScreenState extends State<ContactsScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, String>> contacts = [];
  Map<String, bool> verifiedNumbers = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  void fetchContacts() async {
    setState(() {
      isLoading = true;
    });

    List<Map<String, String>> result = await ContactService.getContacts();

    setState(() {
      contacts = result;
      isLoading = false;
    });

    for (var contact in result) {
      checkNumberInFirebase(contact['number']!);
    }
  }

  void checkNumberInFirebase(String phoneNumber) async {
    bool isRegistered = await ContactService.checkNumberInFirebase(phoneNumber);

    setState(() {
      verifiedNumbers[phoneNumber] = isRegistered;
    });
  }

  void _filterContacts(String query) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var displayedContacts = searchController.text.isEmpty
        ? contacts
        : contacts.where((contact) =>
    contact['name']!
        .toLowerCase()
        .contains(searchController.text.toLowerCase()) ||
        contact['number']!.contains(searchController.text))
        .toList();

    displayedContacts.sort((a, b) => a['name']!.compareTo(b['name']!));

    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      body: SafeArea(
        child: Column(
          children: [
            ContactsBar(
              contactCount: contacts.length,
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
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemCount: displayedContacts.length,
                  itemBuilder: (context, index) {
                    final contact = displayedContacts[index];
                    final phoneNumber = contact['number']!;
                    final isRegistered = verifiedNumbers[phoneNumber] ?? false;

                    return ContactsList(
                      contact: contact,
                      isRegistered: isRegistered,
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
