
import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/accept_terms.dart';
import 'package:litadesarrollos/src/pages/inicio/initial_page.dart';
import 'package:provider/provider.dart';

import '../models/loginmodel.dart';
import '../services/login_service.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);

    final User user = loginService.loginResult.user;


    if (user.acceptTerms == true) {
      return InitialPage();
    }
    if (user.acceptTerms == false) {
      return AcceptTerms();
    }
    if (user == null) {
      return CircularProgressIndicator();
    }
  }
}
