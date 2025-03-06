import 'package:flutter/material.dart';
import 'package:chat/screens/chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredChats = [];

  final List<Map<String, String>> _chats = [
    {
      "name": "Lucas",
      "message": "E aí, beleza?",
      "time": "15:30",
      "avatar": "https://randomuser.me/api/portraits/men/1.jpg",
    },
    {
      "name": "Mariana",
      "message": "Já viu as novidades?",
      "time": "14:15",
      "avatar": "https://randomuser.me/api/portraits/women/2.jpg",
    },
    {
      "name": "Pedro",
      "message": "Te chamo mais tarde!",
      "time": "13:00",
      "avatar": "https://randomuser.me/api/portraits/men/3.jpg",
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredChats = _chats;
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
      _filteredChats = _chats;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _filteredChats = _chats;
    });
  }

  void _filterChats(String query) {
    setState(() {
      _filteredChats = _chats
          .where((chat) => chat["name"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          _isSearching
              ? IconButton(
            icon: Icon(Icons.close),
            onPressed: _stopSearch,
          )
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: _startSearch,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _filteredChats.length,
        itemBuilder: (context, index) {
          final chat = _filteredChats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat["avatar"]!),
            ),
            title: Text(chat["name"]!, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(chat["message"]!),
            trailing: Text(chat["time"]!, style: TextStyle(color: Colors.grey)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConversaScreen(nome: chat["name"]!, avatar: chat["avatar"]!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
