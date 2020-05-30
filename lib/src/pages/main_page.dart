import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/services/graphql_terms_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

import '../models/loginmodel.dart';
import '../models/loginmodel.dart';
import '../services/login_service.dart';
import '../services/login_service.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);
    final terminos = Provider.of<TermsService>(context);
    final User user = loginService.loginResult.user;

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: HexColor(
            user != null ? user.residency.theme.mainColor : Colors.white),
        elevation: 0,
        title: Text(
          'Terminos y Condiciones',
          style: GoogleFonts.sourceSansPro(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            color: Colors.white,
            onPressed: () {
              loginService.deleteAllUserData();
              loginService.loginResult = LoginResult();
              
            },
          )
        ],
      ),
      backgroundColor: user != null
          ? HexColor(user.residency.theme.mainColor)
          : Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  terminos.terminos.globalContent != null
                      ? terminos.terminos.globalContent.content + ''
                      : '',
                  style: GoogleFonts.sourceSansPro(
                      color: HexColor(user != null
                          ? user.residency.theme.secondaryColor
                          : '#ffffff')),
                ),
              ),
              MaterialButton(
                child: Text('Aceptar'),
                onPressed: () {},
                color: HexColor(user != null
                    ? user.residency.theme.secondaryColor
                    : '#ffffff'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
