
import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/accept_terms.dart';
import 'package:litadesarrollos/src/pages/inicio/initial_page.dart';
import 'package:litadesarrollos/src/services/push_notifications_service.dart';
import 'package:provider/provider.dart';

import '../models/loginmodel.dart';
import '../services/login_service.dart';

class MainPage extends StatefulWidget {
  final LoginResult loginResult;

  const MainPage({Key key, @required this.loginResult}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final pushProvider = new PushNotificationsProvider(widget.loginResult);
    pushProvider.mensajes.listen((argumento) {
      if(argumento=="Mensaje en el chat"){
        Navigator.of(context).pushNamed('Chat');
      }else{
        Navigator.of(context).pushNamed('Notifications');
      }



    });
    pushProvider.initNotifications();
  }
  @override
  // ignore: missing_return
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
