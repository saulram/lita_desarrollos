/*
Lista de Providers usados en la app.

 */

import 'package:litadesarrollos/src/pages/account/services/expenses_service.dart';
import 'package:litadesarrollos/src/pages/bazaar/services/bazaar_service.dart';
import 'package:litadesarrollos/src/pages/benefits/services/benefits_service.dart';
import 'package:litadesarrollos/src/pages/chat/services/chat_provider.dart';
import 'package:litadesarrollos/src/pages/chat/services/chat_service.dart';
import 'package:litadesarrollos/src/pages/common_areas/services/common_area_service.dart';
import 'package:litadesarrollos/src/pages/directorio/services/directory_service.dart';
import 'package:litadesarrollos/src/pages/directorio/services/personal_service.dart';
import 'package:litadesarrollos/src/pages/documents/services/documents_service.dart';
import 'package:litadesarrollos/src/pages/inicio/services/preference_service.dart';
import 'package:litadesarrollos/src/pages/lost_found/services/lost_found_service.dart';
import 'package:litadesarrollos/src/pages/maintenance/services/mto_service.dart';
import 'package:litadesarrollos/src/pages/news/services/news_service.dart';
import 'package:litadesarrollos/src/pages/notifications/services/notifications_service.dart';
import 'package:litadesarrollos/src/pages/profile/services/profile_service.dart';
import 'package:litadesarrollos/src/pages/programedvisits/services/visits_service.dart';
import 'package:litadesarrollos/src/pages/votesandpolls/services/polls_service.dart';
import 'package:litadesarrollos/src/pages/votesandpolls/services/votes_service.dart';
import 'package:litadesarrollos/src/pages/wall/services/wall_service.dart';
import 'package:litadesarrollos/src/services/graphql_terms_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providerList = [
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
  ChangeNotifierProxyProvider<LoginService, ProfileService>(
    create: (_) => ProfileService(),
    update: (context, loginService, prefsService) =>
    prefsService..update(loginService.loginResult),
  ),
  ChangeNotifierProvider(
    create: (_) => ChatProvider(),
  ),
];
