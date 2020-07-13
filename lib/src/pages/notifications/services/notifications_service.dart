
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/notifications_list_model.dart';
import 'package:litadesarrollos/src/pages/notifications/services/notification_queries_graphql.dart';
import 'package:litadesarrollos/src/utils/globals.dart';

class NotificationService  with ChangeNotifier{
  static LoginResult _loginResult = LoginResult();
  update(LoginResult lr){
    _loginResult = lr;
    getNotificationsFc();
    notifyListeners();
  }
  LoginResult get loginResult => _loginResult;

  static HttpLink httplink = HttpLink(
      uri: uri,
      headers: <String, String>{
        "Authorization": "${_loginResult.token}",
      });
  static  GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );

  QueryOptions getNotificationsOptions = QueryOptions(
    documentNode: gql(getNotifications),
    fetchPolicy: FetchPolicy.cacheAndNetwork
  );
  bool _loading =false;
  bool get loading => _loading;

  NotificationsList notificationsList = NotificationsList();

  markAsReadFc(String id)async {
    MutationOptions markAsReadOptions = MutationOptions(
        documentNode: gql(markAsRead),
        variables: {
          "id":"$id"
        },
        fetchPolicy: FetchPolicy.cacheAndNetwork
    );
    QueryResult res=await _client.mutate(markAsReadOptions);
    print(res.data);
    getNotificationsFc();

  }

  Future<bool> getNotificationsFc() async{

    _loading = true;
    notifyListeners();
    QueryResult res = await _client.query(getNotificationsOptions);
    if(res.hasException){
      _loading = false;

      notifyListeners();
      return _loading;


    }else{
      _loading = false;

      notificationsList = notificationsListFromJson(jsonEncode(res.data));
      notifyListeners();
      return true;

    }
  }



}