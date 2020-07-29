import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/general_list_model.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/personal_list_model.dart';
import 'package:litadesarrollos/src/models/residents_list_model.dart';
import 'package:litadesarrollos/src/pages/directorio/services/queries.dart';
import 'package:litadesarrollos/src/utils/globals.dart';

class DirectoryService with ChangeNotifier {
  static LoginResult _login;
  Residents residents = Residents();
  Personal personald = Personal();
  General generalServices = General();
  General emergencias = General();
  bool _loading = false;
  bool get loading => _loading;

  void update(LoginResult lr) {
    _login = lr;
    getRes();
    getPers();
    getGen();
    getEmergency();

    _loading = true;

    notifyListeners();
  }

  User get user => _login.user;

  static HttpLink httplink = HttpLink(
      uri: uri,
      headers: <String, String>{
        "Authorization": "${_login.token}",
      });
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );

  //Get Residentes
  QueryOptions options = QueryOptions(
    documentNode: gql(getResidentes),
  );

  //Get Personal
  QueryOptions personal = QueryOptions(
    documentNode: gql(getPersonal),
  );
  //GETgeneral
  QueryOptions general = QueryOptions(
    documentNode: gql(getGeneral),
    variables: {
      "category":"services"
    }
  );
  //get emergency
  QueryOptions emergency = QueryOptions(
      documentNode: gql(getGeneral),
      variables: {
        "category":"emergency"
      }
  );
  //listar emergencias
  Future<bool> getEmergency() async {
    _loading = true;
    notifyListeners();
    QueryResult res = await _client.query(emergency);
    if(res.hasException){
      print(res.data);
      _loading = false;
      notifyListeners();
      return false;
    }else{
      emergencias = generalFromJson(jsonEncode(res.data));
      _loading = false;
      notifyListeners();
      return true;
    }
  }
//listar servicios generales
  Future<bool> getGen() async {
    _loading = true;
    notifyListeners();
    QueryResult res = await _client.query(general);
    if(res.hasException){
      print(res.data);
      _loading = false;
      notifyListeners();
      return false;
    }else{
      generalServices = generalFromJson(jsonEncode(res.data));
      _loading = false;
      notifyListeners();
      return true;
    }
  }
//listar personal
  Future <bool> getPers () async {
    _loading = true;
    notifyListeners();
    QueryResult res = await _client.query(personal);
    if(res.hasException){
      print(res.data);
      _loading = false;
      notifyListeners();
      return false;
    }else{
      _loading = false;
      personald = personalFromJson(jsonEncode(res.data));

      notifyListeners();
      return true;
    }
  }
//listar residentes
  Future<bool> getRes() async {
    _loading = true;
    notifyListeners();
    QueryResult res = await _client.query(options);
    if (res.hasException) {
      _loading = false;
      notifyListeners();
      return false;
    } else {
      residents = residentsFromJson(jsonEncode(res.data));
      _loading = false;
      notifyListeners();
      return true;
    }
  }
}
