import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/visit_model.dart';
import 'package:litadesarrollos/src/models/visits_list_model.dart';
import 'package:litadesarrollos/src/pages/programedvisits/queries/visit_queries.dart';

class VisitService with ChangeNotifier {
  static LoginResult _user;

  LoginResult get user => _user;

  update(LoginResult lr) {
    _user = lr;
    getVisits();

    notifyListeners();
  }

  DateTime _date = DateTime.now();

  DateTime get date => _date;

  set date(DateTime newDate) {
    _date = DateTime(newDate.year, newDate.month, newDate.day);

    notifyListeners();
  }

  DateTime _times = DateTime.now();

  DateTime get times => _times;

  set times(DateTime newtime) {
    _times = newtime;
    print(_times);

    notifyListeners();
  }

  DateTime _timeE = DateTime.now();

  DateTime get timeE => _timeE;

  set timeE(DateTime newtime) {
    _timeE = newtime;

    notifyListeners();
  }

  //Datos de usuario

  String _visitorsName;

  set visitorsName(String vn) {
    _visitorsName = vn;
    notifyListeners();
  }

  String get visitorsName => _visitorsName;

  String _type;

  set type(String tp) {
    _type = tp;
    notifyListeners();
  }

  String get type => _type;

  String _vehicleModel;

  set vehicleModel(String vm) {
    _vehicleModel = vm;
    notifyListeners();
  }

  String get vehicleModel => _vehicleModel;

  String _licensePlate;

  set licensePlate(String vm) {
    _licensePlate = vm;
    notifyListeners();
  }

  String get licensePlate => _licensePlate;

  static HttpLink httplink = HttpLink(
      uri: 'https://lita-261516.appspot.com/graphql',
      headers: <String, String>{
        "Authorization": "${_user.token}",
      });
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );

  MutationOptions options = MutationOptions(
    documentNode: gql(addVisita),
  );
  bool _isloading = false;

  bool get isloading => _isloading;
  VisitAdded vistCreated = VisitAdded();

  Uint8List _currentCode;

  Uint8List get currentCode => _currentCode;

  Future<bool> getQr() async {
    ///Aqui enviamos el query para crear la fecha.
    ///
    DateTime dateInit = DateTime(_date.year, _date.month, _date.day,
        _times.hour, _times.minute, _times.second);
    DateTime dateEnd = DateTime(_date.year, _date.month, _date.day, _timeE.hour,
        _timeE.minute, _timeE.second);

    MutationOptions addVisitaOptions =
        MutationOptions(documentNode: gql(addVisita), variables: {
      "visitorsName": '$_visitorsName',
      "type": '$_type',
      "vehicleModel": '$_vehicleModel',
      "licensePlate": '$_licensePlate',
      'scheduleAt': '$dateInit',
      "untilDate": '$dateEnd'
    });
    _isloading = true;
    notifyListeners();
    QueryResult res = await _client.mutate(addVisitaOptions);
    if (res.hasException) {
      print(res.exception);
      _isloading = false;
      notifyListeners();
      return false;
    } else {
      _isloading = false;
      vistCreated = visitAddedFromJson(jsonEncode(res.data));
      print(vistCreated);

      notifyListeners();
      getVisits();
      return true;
    }
  }

  VisitsList _registoV = VisitsList();
  VisitsList get registrov => _registoV;

  getVisits() async {
    _isloading = true;
    notifyListeners();
    QueryOptions getVisitasOptions =
        QueryOptions(documentNode: gql(getVisitas),fetchPolicy: FetchPolicy.cacheAndNetwork);
    QueryResult res = await _client.query(getVisitasOptions);
    if (res.hasException) {
      print(res.exception);
      _isloading = false;
    } else {
      _registoV = visitsListFromJson(jsonEncode(res.data));
      _isloading = false;

      notifyListeners();
    }
  }
}
