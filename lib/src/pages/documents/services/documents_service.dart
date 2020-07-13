import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/document_list_model.dart';
import 'package:litadesarrollos/src/pages/documents/services/queries.dart';
import 'package:litadesarrollos/src/utils/globals.dart';
import '../../../models/loginmodel.dart';

class DocService with ChangeNotifier {
  static LoginResult _loginResult;

  void update(LoginResult lr) {
    _loginResult = lr;
    getDocuments();
    notifyListeners();
  }
  bool _isloading = false;
  bool get isloading => _isloading;

  static HttpLink httplink = HttpLink(
      uri: uri,
      headers: <String, String>{
        "Authorization": "${_loginResult.token}",
      });
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );

  QueryOptions getNewsOptions = QueryOptions(
      documentNode: gql(getDocumentsQuery),
      fetchPolicy: FetchPolicy.cacheAndNetwork
  );

  Documents _docs = Documents();
  Documents get docs =>_docs;

  Future<void> getDocuments () async {
    _isloading = true;
    notifyListeners();
    QueryResult res = await _client.query(getNewsOptions);

    if(res.hasException){
      _isloading = false;
      print(res.exception);
    }else{
      _isloading = false;
      _docs = documentsFromJson(jsonEncode(res.data));
      print (_docs);
    }
    notifyListeners();

  }


}
