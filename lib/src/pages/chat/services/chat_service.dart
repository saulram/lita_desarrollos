import 'dart:convert';

import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/pages/chat/models/chat_list_model.dart';
import 'package:litadesarrollos/src/utils/globals.dart';

class ChatService with ChangeNotifier {
  static LoginResult _loginResult;

  void update(LoginResult lr) {
    _loginResult = lr;
    if(_loginResult.user!= null){
      _chatParticipants = ["${_loginResult.user.id}"];
    }
    getChats();
    notifyListeners();
  }

  static String query = r'''
query {
    chats {
        _id
        users {
            _id
            completeName
            fullFile
        }
        name
        isActive
    }
}
  ''';

  LoginResult get loginResult => _loginResult;

  static HttpLink httplink = HttpLink(uri: uri, headers: <String, String>{
    "Authorization": "${_loginResult.token}",
  });
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );

  bool _isloading = false;

  bool get isloading => _isloading;

  set isloading(bool isa) {
    _isloading = isa;
    notifyListeners();
  }

  ChatList _chatList;

  ChatList get chatList => _chatList;

  Future<bool> getChats() async {
    QueryOptions options = QueryOptions(
        documentNode: gql(query), fetchPolicy: FetchPolicy.cacheAndNetwork);

    isloading = true;
    QueryResult res = await _client.query(options);

    isloading = false;
    _chatList = chatListFromJson(jsonEncode(res.data));
    notifyListeners();

    return true;
  }

  String _commentId;

  set commentId(String cid) {
    _commentId = cid;
    notifyListeners();
  }

  String get commentId => _commentId;

  void removeParticipant(String id) {
    _chatParticipants.remove(id);
    notifyListeners();
  }

  List<String> _chatParticipants = [];

  List<String> get chatParticipants => _chatParticipants;

  set categories(List<String> cates) {
    _chatParticipants = cates;
    notifyListeners();
  }

  void onCategorySelected(
      bool selected, String categoryName, BuildContext ctx) {
    if (selected == true) {
      _chatParticipants.length == 10
          ? Alert.alert(ctx,
              title: 'Seleccionar',
              content: 'Solo puedes seleccionar 10 opciones',
              ok: 'Entendido')
          : _chatParticipants.add(categoryName);

      print(_chatParticipants);
    } else {
      _chatParticipants.remove(categoryName);
    }
    notifyListeners();
  }

  Future<bool> createChat(String name) async {
    query = r'''
    mutation($users: [ID]!, $name: String) {
    addChat(input: { users: $users, name: $name }) {
        _id
        name
        createdAt
        updatedAt
        isActive
    }
}
    ''';
    MutationOptions options = MutationOptions(
      documentNode: gql(query),
      variables: {
        "users": _chatParticipants,
        "name": name
      }
    );
    isloading = true;
    QueryResult res = await _client.mutate(options);
    isloading = false;
    if(res.hasException){
      return false;
    }
    return true;

  }
}
