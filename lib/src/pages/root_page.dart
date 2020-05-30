import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/main_page.dart';
import 'package:provider/provider.dart';

import '../services/login_service.dart';
import 'login_page.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginServce = Provider.of<LoginService>(context);

    if (loginServce.isloading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } 
    if (loginServce.loginResult.token != '') {
      return MainPage();
    }
    else {
      return LoginPage();
    }
  }
}
