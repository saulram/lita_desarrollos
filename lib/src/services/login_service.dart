import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/utils/globals.dart';

class LoginService with ChangeNotifier {

  //Inicializamos variable de respuesta login.

  LoginResult _loginResult = LoginResult();
  LoginResult get loginResult => _loginResult;
  set loginResult(LoginResult lr) {
    _loginResult = lr;
    notifyListeners();
  }

  //datos para login de usuario
  String _email = '';
  String get email => _email;
  set email(String newMail) {
    _email = newMail;
    notifyListeners();
  }

  String _password = '';
  set password(String passwordnw) {
    _password = passwordnw;
    notifyListeners();
  }

  ///para manejar el login del user
  ///
  bool _isloading = false;
  bool get isloading => _isloading;

  /// Para actualizar el checkbox de remeber username

  bool _value = false;
  bool get rememberUser => _value;
  set rememberUser(bool nv) {
    _value = nv;
    notifyListeners();
  }

  ///Funcion para login de usuario.
  loginUser() async {
    _isloading = true;
    notifyListeners();
    var res = await http.post('$api_url/login/',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _email,
          'password': _password,
          'device': device
        }));
    if (res.statusCode == 404) {
      _isloading = false;
      print(res.body);
    } else {
      _loginResult = loginResultFromJson(res.body);
      _isloading = false;
      print(_loginResult.token);
    }
    notifyListeners();
  }
}
