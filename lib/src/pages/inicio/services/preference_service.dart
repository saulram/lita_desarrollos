import 'dart:convert';

import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/vote_list_model.dart';
import 'package:litadesarrollos/src/utils/globals.dart';

class PrefService with ChangeNotifier {
  List<String> _categories = [];


  void update(LoginResult lr) {
    _loginResult = lr;
    if(_loginResult.user.screenPreferences != null){
      _categories= _loginResult.user.screenPreferences;
    }


    notifyListeners();
  }
  List<String> get categories => _categories;
  set categories ( List<String>  cates){
    _categories=cates;
    notifyListeners();
  }
  void onCategorySelected(bool selected, String categoryName,BuildContext ctx) {
    if (selected == true) {
      _categories.length == 6 ? Alert.alert(ctx,title: 'Seleccionar',content: 'Sólo puedes seleccionar 6 opciones',ok: 'Entendido')
      :_categories.add(categoryName);

      print(_categories);
      





    } else {


        _categories.remove(categoryName);

    }
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
  bool get loading =>_loading;

  Future<LoginResult>updateScreenPreferences({bool isActive,String file})async {
    String query = r'''
    mutation($phone: String, $picture: String, $screenPreferences: [String], $acceptTerms: Boolean, $isPhoneActive: Boolean, $incorrectData: Boolean, $fcmTokens: [String], $fcmTopics: [String]) {
    updateUserByResident(input: { phone: $phone, picture: $picture, screenPreferences: $screenPreferences, acceptTerms: $acceptTerms, isPhoneActive: $isPhoneActive, incorrectData: $incorrectData, fcmTokens: $fcmTokens, fcmTopics: $fcmTopics })
}
    ''';
    MutationOptions options;
    if(file!=null){
       options = MutationOptions(
          documentNode: gql(query),
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          variables: {
            "screenPreferences":_categories,
            "isPhoneActive": _loginResult.user.isPhoneActive,
            "picture": file
          }
      );
    }else{
       options = MutationOptions(
          documentNode: gql(query),
          fetchPolicy: FetchPolicy.cacheAndNetwork,
          variables: {
            "screenPreferences":_categories,
            "isPhoneActive": isActive!=null? isActive : _loginResult.user.isPhoneActive,

          }
      );
    }

    _loading = true;
    notifyListeners();
    QueryResult res = await _client.mutate(options);
    _loading = false;
    notifyListeners();
    if(res.data != null){
      LoginResult userPref = _loginResult;
      if(isActive != null){
        userPref.user.isPhoneActive = isActive;
      }
      userPref.user.screenPreferences = _categories;
      return userPref;

    }else{

      return null;
    }
  }


}
