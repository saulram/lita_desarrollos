import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/chat/models/message.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  int _counter = 0;
  List<MessageList> _messages = List();

  int get counter => _counter;

  set counter(int val) {
    _counter = val;
    notifyListeners();
  }

  List<MessageList> get messages => _messages;

  set messages(List<MessageList> messages) {
    _messages = messages;
    notifyListeners();
  }
  clearChat(){
    _messages = [];
  }

  void addMessage(){

  }

  static ChatProvider of(BuildContext context) =>
      Provider.of<ChatProvider>(context);
}
