import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/comment_list.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/pages/directorio/services/queries.dart';

class PersonalService with ChangeNotifier {
  static LoginResult login;
  bool _isloading = false;
  bool get isloading => _isloading;

  void update(LoginResult lr) {
    login = lr;
    notifyListeners();
    print(login.token);
  }

  static String _text = '';

  String get text => _text;

  set text(String texto) {
    _text = texto;
    notifyListeners();
  }

  static HttpLink httplink = HttpLink(
      uri: 'https://lita-261516.appspot.com/graphql',
      headers: <String, String>{
        "Authorization": "${login.token}",
      });
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),

    link: httplink,
  );

  Future<bool> addMensaje(String idPersonal) async {
    //GETgeneral
    MutationOptions addMensaje = MutationOptions(
      documentNode: gql(addComment),
      variables: {"personalId": "$idPersonal","text": _text},
    );
    _isloading = true;
    notifyListeners();
    QueryResult res = await _client.mutate(addMensaje);
    if (res.hasException) {
      print(res.exception);
      _isloading = false;
      notifyListeners();
      return false;
    } else {
      print(res.data);
      _isloading = false;
      notifyListeners();
      return true;
    }
  }

  CommentList comments = CommentList ();
  void getComments (String pId) async{
    QueryOptions getComments = QueryOptions(
      documentNode: gql(listPersonalComentsQuery),
      variables: {
        "personalId": pId
      },
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );
    QueryResult res = await _client.query(getComments);
    if(res.hasException){
      print(res.exception);
    }else{

      comments = commentListFromJson(jsonEncode(res.data));
      print(res.data);
      notifyListeners();
    }
  }
}
