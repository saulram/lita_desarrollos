import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/general_list_model.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/personal_list_model.dart';
import 'package:litadesarrollos/src/models/residents_list_model.dart';
import 'package:litadesarrollos/src/pages/account/models/expenses_model.dart';
import 'package:litadesarrollos/src/pages/directorio/services/queries.dart';
import 'package:litadesarrollos/src/utils/globals.dart';

class ExpensesService with ChangeNotifier {
  static LoginResult _login;

  bool _loading = false;
  bool get loading => _loading;

  void update(LoginResult lr) {
    _login = lr;

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

  static String incomeExpensesQuery = r'''
  query($type: String) {
    incomesExpenses(filters: { type: $type}) {
        concept {
            title
        }
        movementType
        amount
        overdue
        incomeFullFile
        folioNumber
        termPaidDateFormat
    }
}
  ''';

  //Get Residentes
  QueryOptions options = QueryOptions(
    documentNode: gql(incomeExpensesQuery),
  );

  ExpansesList _expansesList ;
  ExpansesList get expanse =>_expansesList;

  //listar emergencias
  Future<bool> getEmergency() async {
    _loading = true;
    notifyListeners();
    QueryResult res = await _client.query(options);
    if(res.hasException){
      print(res.data);
      _loading = false;
      notifyListeners();
      return false;
    }else{
      _expansesList = expansesListFromJson(jsonEncode(res.data));
      _loading = false;
      print(_expansesList);
      notifyListeners();
      return true;
    }
  }

}
