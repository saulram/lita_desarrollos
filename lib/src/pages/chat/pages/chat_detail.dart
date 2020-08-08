import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/pages/chat/models/message.dart';
import 'package:litadesarrollos/src/pages/chat/services/chat_provider.dart';
import 'package:litadesarrollos/src/pages/chat/utils/socket_clienr.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class ChatDetailPage extends StatefulWidget {
  final String token, chatId, userId, chatName;

  const ChatDetailPage({this.token, this.chatId, this.userId, this.chatName});

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  ChatProvider _chat;
  TextEditingController _controller = TextEditingController();
  final _socketClient = SocketClient();
  List<MessageList> chatHistory = [];

  @override
  void initState() {
    super.initState();
    _connectSocket();
  }

  _connectSocket() async {
    await _socketClient.conect(widget.token, widget.chatId, widget.userId);
    _socketClient.onNewMessage = (data) {
      chatHistory = messageListFromJson(jsonEncode(data));
      _chat.messages = chatHistory;
    };
    _socketClient.onMessageSent = (data) {
      MessageList _msg = MessageList(
        id: data["_id"],
        chatId: data["chatId"],
        updatedAt: DateTime.parse(data["updatedAt"]),
        senderId: SenderId.fromJson(data["senderId"]),
        text: data["text"],
      );

      chatHistory.add(_msg);
      _chat.messages = chatHistory;
    };
  }

  @override
  Widget build(BuildContext context) {
    _chat = ChatProvider.of(context);
    final loginProvider = Provider.of<LoginService>(context);
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    double px = 1 / pixelRatio;

    BubbleStyle styleSomebody = BubbleStyle(
      nip: BubbleNip.leftTop,
      color: HexColor('#f2f2f2'),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
    BubbleStyle styleMe = BubbleStyle(
      nip: BubbleNip.rightBottom,
      color: HexColor(
          loginProvider.loginResult.user.residency.theme.secondaryColor),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 5.0, left: 50.0),
      alignment: Alignment.topRight,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${widget.chatName}'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _chat.messages != null
                  ? Expanded(
                      child: ListView.builder(
                        reverse: true,
                        itemCount: _chat.messages.length,
                        itemBuilder: (BuildContext ctx, int i) {
                          if (_chat.messages[i].senderId.completeName ==
                              loginProvider.loginResult.user.completeName) {
                            return Bubble(
                              style: styleMe,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    '${_chat.messages[i].text}',
                                    style: GoogleFonts.sourceSansPro(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          }
                          return Bubble(
                            style: styleSomebody,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${_chat.messages[i].senderId.completeName} \n',
                                  style: GoogleFonts.sourceSansPro(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${_chat.messages[i].text}',
                                  style: GoogleFonts.sourceSansPro(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Form(
                child: CupertinoTextField(
                  controller: _controller,
                  placeholder: 'Escribe aquí',
                  maxLines: 3,
                  maxLength: 250,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  style: GoogleFonts.sourceSansPro(),
                  suffix: IconButton(
                    color: accentLita,
                    icon: Icon(FontAwesomeIcons.paperPlane),
                    onPressed: () {
                      _sendMessage(loginProvider.loginResult.user);
                    },
                  ),
                  decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xffd2d2d2))),
                ),
              ),
            ],
          ),
        ),
      ),
      // Esta coma final hace al auto-formateo más agradable a los métodos de compilación.
    );
  }

  void _sendMessage(User user) {
    if (_controller.text.isNotEmpty) {
      MessageList _msg = MessageList(
        id: "",
        chatId: widget.chatId,
        updatedAt: DateTime.now(),
        senderId: SenderId(completeName: user.completeName, id: widget.userId),
        text: _controller.text,
      );
      chatHistory.insert(0, _msg);
      _chat.messages = chatHistory;

      _socketClient.sendmessage(_controller.text, widget.chatId, widget.userId);
      _controller.text = '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _chat.clearChat();

    _socketClient.disconnect();
  }
}
