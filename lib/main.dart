import 'dart:io';

import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:litadesarrollos/src/pages/account/services/expenses_service.dart';
import 'package:litadesarrollos/src/pages/bazaar/services/bazaar_service.dart';
import 'package:litadesarrollos/src/pages/benefits/services/benefits_service.dart';
import 'package:litadesarrollos/src/pages/chat/services/chat_service.dart';
import 'package:litadesarrollos/src/pages/chat/utils/app_initializer.dart';
import 'package:litadesarrollos/src/pages/chat/utils/dependency_injection.dart';
import 'package:litadesarrollos/src/pages/common_areas/services/common_area_service.dart';
import 'package:litadesarrollos/src/pages/directorio/services/directory_service.dart';
import 'package:litadesarrollos/src/pages/directorio/services/personal_service.dart';
import 'package:litadesarrollos/src/pages/documents/services/documents_service.dart';
import 'package:litadesarrollos/src/pages/inicio/services/preference_service.dart';
import 'package:litadesarrollos/src/pages/lost_found/services/lost_found_service.dart';
import 'package:litadesarrollos/src/pages/maintenance/services/mto_service.dart';
import 'package:litadesarrollos/src/pages/news/services/news_service.dart';
import 'package:litadesarrollos/src/pages/notifications/services/notifications_service.dart';
import 'package:litadesarrollos/src/pages/programedvisits/services/visits_service.dart';
import 'package:litadesarrollos/src/pages/root_page.dart';
import 'package:litadesarrollos/src/pages/votesandpolls/services/polls_service.dart';
import 'package:litadesarrollos/src/pages/votesandpolls/services/votes_service.dart';
import 'package:litadesarrollos/src/pages/wall/services/wall_service.dart';
import 'package:litadesarrollos/src/services/graphql_terms_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'src/services/login_service.dart';
Injector injector;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


void main() async {
  DependencyInjection().initialise(Injector.getInjector());
  injector = Injector.getInjector();
  HttpOverrides.global = new MyHttpOverrides();
  await AppInitializer().initialise(injector);


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
        ),
        ChangeNotifierProxyProvider<LoginService, VoteService>(
          create: (_) => VoteService(),
          update: (context, loginService, voteService) =>
              voteService..update(loginService.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, PollService>(
          create: (_) => PollService(),
          update: (context, loginService, pollService) =>
          pollService..update(loginService.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, CommonService>(
          create: (_) => CommonService(),
          update: (context, loginService, commonService) =>
          commonService..update(loginService.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, WallService>(
          create: (_) => WallService(),
          update: (context, loginService, commonService) =>
          commonService..update(loginService.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, LostService>(
          create: (_) => LostService(),
          update: (context, loginService, lostService) =>
          lostService..update(loginService.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, BazaarService>(
          create: (_) => BazaarService(),
          update: (context, loginService, bazaarService) =>
          bazaarService..update(loginService.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, ChatService>(
          create: (_) => ChatService(),
          update: (context, loginService, bazaarService) =>
          bazaarService..update(loginService.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, BenefitsService>(
          create: (_) => BenefitsService(),
          update: (context, loginService, bazaarService) =>
          bazaarService..update(loginService.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, ExpensesService>(
          create: (_) => ExpensesService(),
          update: (context, loginService, bazaarService) =>
          bazaarService..update(loginService.loginResult),
        ),
        ChangeNotifierProxyProvider<LoginService, PrefService>(
          create: (_) => PrefService(),
          update: (context, loginService, prefsService) =>
          prefsService..update(loginService.loginResult),
        ),
      ],
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
