import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/account/main_account.dart';
import 'package:litadesarrollos/src/pages/bazaar/bazar_main.dart';
import 'package:litadesarrollos/src/pages/benefits/benefitsmain_dart.dart';
import 'package:litadesarrollos/src/pages/chat/chat_main_page.dart';
import 'package:litadesarrollos/src/pages/common_areas/main_common_areas.dart';
import 'package:litadesarrollos/src/pages/directorio/directory.dart';
import 'package:litadesarrollos/src/pages/documents/documents_main.dart';
import 'package:litadesarrollos/src/pages/inicio/pref_page.dart';
import 'package:litadesarrollos/src/pages/lost_found/lost_found_main.dart';
import 'package:litadesarrollos/src/pages/maintenance/maintenance_main.dart';
import 'package:litadesarrollos/src/pages/news/news_main.dart';
import 'package:litadesarrollos/src/pages/notifications/main_notification_page.dart';
import 'package:litadesarrollos/src/pages/programedvisits/visitaProgramada.dart';
import 'package:litadesarrollos/src/pages/root_page.dart';
import 'package:litadesarrollos/src/pages/votesandpolls/votes_and_polls_main_page.dart';


/*
Lista de rutas de la app.
 */

Map<String, Widget Function(BuildContext)> routes = {
  'root': (_) => RootPage(),
  'preferences-section': (_) => PreferenceSelection(),
  'Directorio': (_) => DirectoryPage(),
  'Visitas-Programadas': (_) => VisitaProgramadaPage(),
  'Mantenimiento': (_) => MaintenancePage(),
  'Avisos-page': (_) => NewsPage(),
  'Documents-page': (_) => DocumentsPage(),
  'Notifications': (_) => NotificationsPage(),
  'Vote': (_) => VotesAndPolls(),
  'Common':(_)=>CommonAreasPage(),
  'Lost':(_)=>LostFoundMain(),
  'Bazar':(_)=>BazaarMain(),
  'Chat':(_)=>MainChatPage(),
  'Benefits':(_)=>BenefitsMain(),
  'Account':(_)=>AccountPage()
};