import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/news/services/news_service.dart';
import 'package:litadesarrollos/src/pages/news/widgets/article_card.dart';
import 'package:litadesarrollos/src/pages/notifications/widgets/notification_card.dart';
import 'package:litadesarrollos/src/pages/notifications/services/notifications_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/widgets/bottom_lita.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginService>(context);

    final notificationService = Provider.of<NotificationService>(context);
    return loginProvider.loginResult.user != null
        ? Scaffold(
            endDrawer: DrawerLita(),
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                'Notificaciones',
                style: GoogleFonts.sourceSansPro(color: Colors.black),
              ),
            ),
            body: Column(
              children: <Widget>[
                notificationService.loading == false
                    ? Expanded(
                        child: RefreshIndicator(
                          onRefresh: notificationService.getNotificationsFc,
                          child: ListView.builder(
                              itemCount: notificationService
                                      .notificationsList.notifications !=null? notificationService.notificationsList.notifications.length :
                                  0,
                              itemBuilder: (BuildContext ctx, int i) {
                                return Container(
                                    child: NotificationsCard(
                                  doc: notificationService
                                      .notificationsList.notifications[i],
                                ));
                              }),
                        ),
                      )
                    : Center(child: CircularProgressIndicator())
              ],
            ),
            bottomNavigationBar: BottomLita(),
          )
        : Scaffold();
  }
}
