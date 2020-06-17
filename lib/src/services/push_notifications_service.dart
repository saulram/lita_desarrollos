import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/services/graphql/saveFCMToken.dart';

class PushNotificationsProvider {
  final LoginResult loginResult;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mensajesStreamController = StreamController<String>.broadcast();

  PushNotificationsProvider(this.loginResult);

  Stream<String> get mensajes => _mensajesStreamController.stream;

  void updateFCM(LoginResult loginUser, String deviceToken) async {
    bool exist = false;
    HttpLink httplink = HttpLink(
        uri: 'https://lita-261516.appspot.com/graphql',
        headers: {"Authorization": loginUser.token});
    GraphQLClient _client = GraphQLClient(
      cache: InMemoryCache(),
      link: httplink,
    );

    if (loginUser.user.fcmTokens != null) {
      await Future.forEach(loginUser.user.fcmTokens, (String fcmToken) {
        if (deviceToken == fcmToken) {
          exist = true;
        }
      });

      if (exist == false) {
        List<String> firebaseTokens = loginUser.user.fcmTokens;
        firebaseTokens.add(deviceToken);
        QueryOptions saveFCMTokenOptions = QueryOptions(
            documentNode: gql(saveFCMTokenQuery),
            variables: <String, dynamic>{"fcmTokens": firebaseTokens});
        QueryResult res = await _client.query(saveFCMTokenOptions);
      }
    }
  }

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: false));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {});

    _firebaseMessaging.getToken().then((token) async {
      //mutacion para agregar el token
      updateFCM(this.loginResult, token);
    });

    _firebaseMessaging.configure(onMessage: (info) {
      // ignore: missing_return

      //Llega cuando esta abierta la app

      print('=======ON MESSAGE =========\n ${info}');
      String argumento = 'no-data';
      if (Platform.isIOS) {
        argumento = info['aps']['title'] ?? 'no-data';
      }
      if (Platform.isAndroid) {
        argumento = info['notification']['title'] ?? 'no-data';
        print(argumento);
      }
      _mensajesStreamController.sink.add(argumento);
    }, onLaunch: (info) {
      // ignore: missing_return
      print('=======ON Launch =========\n $info');
      String argumento = 'no-data';
      if (Platform.isIOS) {
        argumento = info['aps']['title'] ?? 'no-data';
      }
      if (Platform.isAndroid) {
        argumento = info['notification']['title'] ?? 'no-data';
        print(argumento);
      }
      _mensajesStreamController.sink.add(argumento);
    }, onResume: (info) {
      // ignore: missing_return
      print('=======ON resume =========\n $info');

      String argumento = 'no-data';
      if (Platform.isIOS) {
        argumento = info['aps']['title'] ?? 'no-data';
      }
      if (Platform.isAndroid) {
        argumento = info['notification']['title'] ?? 'no-data';
        print(argumento);
      }
      _mensajesStreamController.sink.add(argumento);
    });
  }

  dispose() {
    _mensajesStreamController.close();
  }
}
