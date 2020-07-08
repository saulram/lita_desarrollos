import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/notifications/widgets/notification_card.dart';
import 'package:litadesarrollos/src/pages/notifications/services/notifications_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
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
                    :
                Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int i) {
                        return Center(
                          child: CardSkeleton(
                            style: SkeletonStyle(
                              theme: SkeletonTheme.Light,
                              isShowAvatar: true,
                              isCircleAvatar: true,
                              borderRadius:
                              BorderRadius.all(Radius.circular(16.0)),
                              padding: EdgeInsets.all(32.0),
                              barCount: 2,
                              colors: [
                                Colors.grey[300],
                                Colors.grey[200],
                                Colors.grey[100]
                              ],
                              backgroundColor: Color(0xffffff),
                              isAnimation: true,

                            ),
                          ),
                        );
                      }),
                )

              ],
            ),
            bottomNavigationBar: BottomLita(),
          )
        : Scaffold();
  }
}
