import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/vote_list_model.dart';
import 'package:litadesarrollos/src/utils/globals.dart';

class PrefService with ChangeNotifier {


  void update(LoginResult lr) {
    _loginResult = lr;

    notifyListeners();
  }

  static LoginResult _loginResult = LoginResult();

  LoginResult get loginResult => _loginResult;

  static HttpLink httplink = HttpLink(
      uri: uri,
      headers: <String, String>{
        "Authorization": "${_loginResult.token}",
      });
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );

  QueryOptions getVotationsOptions = QueryOptions(
      documentNode: gql(''),
      fetchPolicy: FetchPolicy.cacheAndNetwork);
  VoteList votations = VoteList();
  bool _loading = false;


}
