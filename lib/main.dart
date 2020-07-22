import 'dart:io';
import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/root_page.dart';
import 'package:litadesarrollos/src/utils/provider_list.dart';
import 'package:litadesarrollos/src/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


void main() async {

  HttpOverrides.global = new MyHttpOverrides();



  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: providerList,
      child: AlertProvider(
        child: MaterialApp(
          navigatorKey: navigatorKey,
          routes: routes,
          debugShowCheckedModeBanner: false,
          title: 'Lita Desarrollos',
          theme: ThemeData(
            primaryColor: Color(0xff00CC87),
            accentColor: Color(0xff4E76B6),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: RootPage(),
        ),
      ),
    );
  }
}
