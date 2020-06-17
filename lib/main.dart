import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/directorio/directory.dart';
import 'package:litadesarrollos/src/pages/directorio/services/directory_service.dart';
import 'package:litadesarrollos/src/pages/directorio/services/personal_service.dart';
import 'package:litadesarrollos/src/pages/documents/documents_main.dart';
import 'package:litadesarrollos/src/pages/documents/services/documents_service.dart';
import 'package:litadesarrollos/src/pages/inicio/pref_page.dart';

import 'package:litadesarrollos/src/pages/maintenance/maintenance_main.dart';
import 'package:litadesarrollos/src/pages/maintenance/services/mto_service.dart';
import 'package:litadesarrollos/src/pages/news/news_main.dart';
import 'package:litadesarrollos/src/pages/news/services/news_service.dart';
import 'package:litadesarrollos/src/pages/notifications/main_notification_page.dart';
import 'package:litadesarrollos/src/pages/notifications/services/notifications_service.dart';
import 'package:litadesarrollos/src/pages/programedvisits/visitaProgramada.dart';
import 'package:litadesarrollos/src/pages/programedvisits/services/visits_service.dart';
import 'package:litadesarrollos/src/pages/root_page.dart';
import 'package:litadesarrollos/src/services/graphql_terms_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'src/services/login_service.dart';

void main() {
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
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginService(),
        ),
        ChangeNotifierProxyProvider<LoginService, TermsService>(
          create: (_) => TermsService(),
          update: (context, loginServce, termService) =>
              termService..update(loginServce.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, DirectoryService>(
          create: (_) => DirectoryService(),
          update: (context, loginServce, directoryService) =>
              directoryService..update(loginServce.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, PersonalService>(
          create: (_) => PersonalService(),
          update: (context, loginServce, personalService) =>
              personalService..update(loginServce.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, VisitService>(
          create: (_) => VisitService(),
          update: (context, loginServce, visitService) =>
              visitService..update(loginServce.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, MtoService>(
          create: (_) => MtoService(),
          update: (context, loginServce, mtoService) =>
              mtoService..update(loginServce.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, NewsService>(
          create: (_) => NewsService(),
          update: (context, loginServce, newsService) =>
              newsService..update(loginServce.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, DocService>(
          create: (_) => DocService(),
          update: (context, loginServce, docsService) =>
              docsService..update(loginServce.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, NotificationService>(
          create: (_) => NotificationService(),
          update: (context, loginServce, notificationsService) =>
          notificationsService..update(loginServce.loginResult),
        )
      ],
      child: AlertProvider(
        child: MaterialApp(
          navigatorKey: navigatorKey,

          routes: {
            'root': (_) => RootPage(),
            'preferences-section': (_) => PreferenceSelection(),
            'Directorio': (_) => DirectoryPage(),
            'Visitas-Programadas': (_) => VisitaProgramadaPage(),
            'Mantenimiento': (_) => MaintenancePage(),
            'Avisos-page': (_) => NewsPage(),
            'Documents-page': (_) => DocumentsPage(),
            'Notifications':(_)=>NotificationsPage()
          },
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
