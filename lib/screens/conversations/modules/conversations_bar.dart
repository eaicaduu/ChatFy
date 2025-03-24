import 'package:flutter/material.dart';
import '../../../values/colors.dart';
import '../contacts.dart';

class ConversationsBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const ConversationsBar({super.key}) : preferredSize = const Size.fromHeight(110.0);

  @override
  ConversationsBarState createState() => ConversationsBarState();
}

class ConversationsBarState extends State<ConversationsBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showClearIcon = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _showClearIcon = _focusNode.hasFocus || _controller.text.isNotEmpty;
      });
    });

    _controller.addListener(() {
      setState(() {
        _showClearIcon = _controller.text.isNotEmpty || _focusNode.hasFocus;
      });
    });
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
        child: const ContactsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: _showClearIcon ? 0.0 : 1.0,
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
                  onPressed: _showClearIcon
                      ? () {
                    _controller.clear();
                    setState(() {
                      _showClearIcon = false;
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
            transform: _showClearIcon
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
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                suffixIcon: _showClearIcon
                    ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _controller.clear();
                    FocusScope.of(context).unfocus();
                    setState(() => _showClearIcon = false);
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
