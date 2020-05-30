import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/accept_terms.dart';
import 'package:litadesarrollos/src/services/graphql_terms_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

import '../models/loginmodel.dart';
import '../services/login_service.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);

    final User user = loginService.loginResult.user;
    print(loginService.loginResult.user.acceptTerms);

    if (user.acceptTerms == true) {
      return Scaffold(body: Container( child: Center(child: Text('El usuario acepto terminos')),));
    }
    if( user.acceptTerms == false){
      return AcceptTerms();
    }
    if(user ==null){
      return CircularProgressIndicator();
    }
  }
}
