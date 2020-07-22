import 'package:flutter/material.dart';
import 'package:litadesarrollos/main.dart';
import 'package:litadesarrollos/src/pages/chat/utils/socket_client.dart';
import 'package:litadesarrollos/src/pages/chat/utils/socket_service.dart';

class ChatDetailPage extends StatefulWidget {
  final String token;

  const ChatDetailPage({this.token});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  TextEditingController _controller = TextEditingController();
  final SocketService socketService = injector.get<SocketService>();


  @override
  void initState() {
   super.initState();
   _connectSocket();
  }
  _connectSocket ()async {

    socketService.createSocketConnection();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
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
  }
}
