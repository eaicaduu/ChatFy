import 'package:chat/values/colors.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'contacts.dart';
import '../../database/database.dart';

class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  ChatListScreenState createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ConversationsScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredChats = [];
  List<Map<String, dynamic>> _chats = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    List<Map<String, dynamic>> messages = await _dbHelper.getMessage();
    setState(() {
      _chats = messages;
      _filteredChats = messages;
    });
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _filteredChats = List.from(_chats);
    });
  }

  void _filterChats(String query) {
    setState(() {
      _filteredChats = _chats
          .where((chat) => chat["text"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _openContactsScreen() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        margin: const EdgeInsets.only(top: 16.0),
        height: MediaQuery.of(context).size.height * 0.8,
        child: ContactsScreen(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getBackgroundColor(context),
        title: _isSearching
            ? TextField(
          controller: _searchController,
          onChanged: _filterChats,
          autofocus: true,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: "Pesquisar...",
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
          ),
        )
            : Text("Conversas"),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _isSearching ? _stopSearch : _startSearch,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _openContactsScreen,
          ),
        ],
      ),
      body: _filteredChats.isEmpty
          ? Center(
        child: Text(
          "Sem conversas",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: _filteredChats.length,
        itemBuilder: (context, index) {
          final chat = _filteredChats[index];
          return ListTile(
            title: Text(chat["text"], style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(nome: '', photo: '',),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
