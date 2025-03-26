import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../values/colors.dart';
import '../contacts.dart';
import 'contacts_service.dart';

class ConversationsBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const ConversationsBar({super.key})
      : preferredSize = const Size.fromHeight(110.0);

  @override
  ConversationsBarState createState() => ConversationsBarState();
}

class ConversationsBarState extends State<ConversationsBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool showClearIcon = false;
  List<Map<String, String>> contacts = [];
  Map<String, bool> verifiedNumbers = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContacts();

    _focusNode.addListener(() {
      setState(() {
        showClearIcon = _focusNode.hasFocus || _controller.text.isNotEmpty;
      });
    });

    _controller.addListener(() {
      setState(() {
        showClearIcon = _controller.text.isNotEmpty || _focusNode.hasFocus;
      });
    });
  }

  void fetchContacts() async {
    List<Map<String, String>> result = await ContactService.getContacts();
    if (mounted) {
      setState(() {
        contacts = result;
        isLoading = false;
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

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void openContactsScreen(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: getBackgroundColor(context),
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        margin: const EdgeInsets.only(top: 16.0),
        height: MediaQuery.of(context).size.height * 0.8,
        child: ContactsScreen(
          contacts: contacts,
          verifiedNumbers: verifiedNumbers,
          isLoading: isLoading,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: showClearIcon ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: getBackgroundColor(context),
            title: const Text("Conversas"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 32,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: showClearIcon
                      ? () {
                          _controller.clear();
                          setState(() {
                            showClearIcon = false;
                          });
                          FocusScope.of(context).unfocus();
                        }
                      : () => openContactsScreen(context),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            transform: showClearIcon
                ? Matrix4.translationValues(0, -50, 0)
                : Matrix4.translationValues(0, 0, 0),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: "Pesquisar...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.withValues(alpha: 0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0),
                suffixIcon: showClearIcon
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _controller.clear();
                          FocusScope.of(context).unfocus();
                          setState(() => showClearIcon = false);
                        },
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
