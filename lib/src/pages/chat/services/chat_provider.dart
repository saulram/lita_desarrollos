import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatProvider extends ChangeNotifier {
  int _counter = 0;
  List _messages = List();

  int get counter => _counter;

  set counter(int val) {
    _counter = val;
    notifyListeners();
  }

  List get messages => _messages;

  set messages(List messages) {
    _messages = messages;
    notifyListeners();
  }

  void addMessage(){

  }

  static ChatProvider of(BuildContext context) =>
      Provider.of<ChatProvider>(context);
}
