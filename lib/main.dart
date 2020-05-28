import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/login_page.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lita Desarrollos',
        theme: ThemeData(
          primaryColor: Color(0xff00CC87),
          accentColor: Color(0xff4E76B6),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
      ),
    );
  }
}
