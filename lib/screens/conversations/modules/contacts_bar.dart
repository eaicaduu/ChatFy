import 'package:flutter/material.dart';

class ContactsBar extends StatefulWidget {
  final int contactCount;
  final int contactCountFilter;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  const ContactsBar({
    super.key,
    required this.contactCount,
    required this.contactCountFilter,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  ContactsBarState createState() => ContactsBarState();
}

class ContactsBarState extends State<ContactsBar> {
  final FocusNode _focusNode = FocusNode();
  bool showClearIcon = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        showClearIcon = _focusNode.hasFocus || widget.searchController.text.isNotEmpty;
      });
    });

    widget.searchController.addListener(() {
      setState(() {
        showClearIcon = widget.searchController.text.isNotEmpty || _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.contactCountFilter} Contatos",
                style: const TextStyle(fontSize: 22),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                iconSize: 32,
                onPressed: () {
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: widget.searchController,
            focusNode: _focusNode,
            onChanged: widget.onSearchChanged,
            decoration: InputDecoration(
              hintText: "Pesquisar...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.withValues(alpha: 0.2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              suffixIcon: showClearIcon
                  ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  widget.searchController.clear();
                  FocusScope.of(context).unfocus();
                  setState(() => showClearIcon = false);
                },
              )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
