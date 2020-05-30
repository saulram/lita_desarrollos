import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/terms_model.dart';
import 'package:litadesarrollos/src/services/graphql/terms.dart';

import '../models/loginmodel.dart';

class TermsService with ChangeNotifier {
  void update(LoginResult lr) {
    loginResult = lr;
    token = lr.token;
    notifyListeners();
    if (token != null) {
      getTerminos();
    }
  }

  LoginResult loginResult = LoginResult();
  static String token;

// ...

  static HttpLink httplink = HttpLink(
      uri: 'https://lita-261516.appspot.com/graphql',
      headers: <String, String>{
        "Authorization": "$token",
      });

  Terms _teminos = Terms();

  Terms get terminos => _teminos;

  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );

// ...

  QueryOptions options = QueryOptions(
      documentNode: gql(getTerms),
      variables: <String, dynamic>{"slug": "terminos-y-condiciones"});

  MutationOptions acceptTerms = MutationOptions(
      documentNode: gql(updateByRes),
      variables: <String, dynamic>{"acceptTerms":true });

  void getTerminos() async {
    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
    } else {
      _teminos = termsFromJson(jsonEncode(result.data));

      notifyListeners();
    }
  }

 Future<bool> termsAccepted() async {

    final QueryResult result = await _client.mutate(acceptTerms);

    if(result.hasException){
      print(result.exception.toString());
      return false;

    }else{

    return true;

    }
  }
}
