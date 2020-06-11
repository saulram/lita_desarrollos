import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/news_model_list.dart';
import 'package:litadesarrollos/src/pages/news/services/queries.dart';
import '../../../models/loginmodel.dart';

class NewsService with ChangeNotifier {
  static LoginResult _loginResult;

  void update(LoginResult lr) {
    _loginResult = lr;
    getNews();
    notifyListeners();
  }
  bool _isloading = false;
  bool get isloading => _isloading;

  NewsList _newsList = NewsList();
  NewsList get newsList => _newsList;
  static HttpLink httplink = HttpLink(
      uri: 'https://lita-261516.appspot.com/graphql',
      headers: <String, String>{
        "Authorization": "${_loginResult.token}",
      });
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );

  QueryOptions getNewsOptions = QueryOptions(
    documentNode: gql(getNewsQuery),
    fetchPolicy: FetchPolicy.cacheAndNetwork
  );

 Future<void> getNews () async {
   _isloading = true;
   notifyListeners();
    QueryResult res = await _client.query(getNewsOptions);

    if(res.hasException){
      _isloading = false;
      print(res.exception);
    }else{
      _isloading = false;
      _newsList = newsListFromJson(jsonEncode(res.data));
      print (_newsList);
    }
    notifyListeners();

  }


}
