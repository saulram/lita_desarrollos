import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/chat/utils/socket_clienr.dart';

class ChatDetailPage extends StatefulWidget {
  final String token,chatId,userId;

  const ChatDetailPage({this.token, this.chatId, this.userId});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController _controller = TextEditingController();
  final _socketClient = SocketClient();


  @override
  void initState() {

    super.initState();
   _connectSocket();

  }
  _connectSocket() async {
    _socketClient.conect(widget.token,widget.chatId,widget.userId);
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // Esta coma final hace al auto-formateo más agradable a los métodos de compilación.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {}
  }

  @override
  void dispose() {

    super.dispose();
    print('Se cerro el chat');

    _socketClient.disconnect();

  }
}
