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
  bool showIcon = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        showIcon =
            _focusNode.hasFocus || widget.searchController.text.isNotEmpty;
      });
    });

    widget.searchController.addListener(() {
      setState(() {
        showIcon =
            widget.searchController.text.isNotEmpty || _focusNode.hasFocus;
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
          child: AnimatedOpacity(
            opacity: showIcon ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.contactCountFilter == 0
                    ? const Text(
                        "Nenhum Contato",
                        style: TextStyle(fontSize: 22),
                      )
                    : widget.contactCountFilter == 1
                        ? const Text(
                            "1 Contato",
                            style: TextStyle(fontSize: 22),
                          )
                        : Text(
                            "${widget.contactCountFilter} Contatos",
                            style: const TextStyle(fontSize: 22),
                          ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  iconSize: 32,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            transform: showIcon
                ? Matrix4.translationValues(0, -50, 0)
                : Matrix4.translationValues(0, 0, 0),
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
                suffixIcon: showIcon
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          widget.searchController.clear();
                          FocusScope.of(context).unfocus();
                          setState(() => showIcon = false);
                        },
                      )
                    : null,
              ),
            ),
          ),
        )
      ],
    );
  }
}
