import 'package:flutter/material.dart';
import '../database/database.dart';


class ChatScreen extends StatefulWidget {
  final String nome;
  final String photo;

  const ChatScreen({super.key, required this.nome, required this.photo});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _mensagens = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _carregarMensagens();
  }

  Future<void> _carregarMensagens() async {
    List<Map<String, dynamic>> mensagens = await _dbHelper.getMessage();
    setState(() {
      _mensagens.clear();
      _mensagens.addAll(mensagens.map((msg) => msg["text"].toString()));
    });
  }

  Future<void> _enviarMensagem() async {
    if (_controller.text.isNotEmpty) {
      await _dbHelper.saveMessage(_controller.text);
      setState(() {
        _mensagens.insert(0, _controller.text);
      });
      _controller.clear();
    }
  }

  Future<void> _deletarMensagens() async {
    await _dbHelper.deleteMessage();
    setState(() {
      _mensagens.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(widget.photo)),
            SizedBox(width: 10),
            Text(widget.nome),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deletarMensagens,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _mensagens.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(_mensagens[index]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Digite uma mensagem...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: _enviarMensagem,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
