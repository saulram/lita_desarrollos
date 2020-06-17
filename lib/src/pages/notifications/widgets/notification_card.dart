import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/notifications_list_model.dart';
import 'package:litadesarrollos/src/pages/notifications/pages/notification_detail.dart';
import 'package:litadesarrollos/src/pages/notifications/services/notifications_service.dart';

import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:provider/provider.dart';

class NotificationsCard extends StatelessWidget {
  final Notify doc;

  const NotificationsCard({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationprovider = Provider.of<NotificationService>(context);
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: CircleAvatar(
                  backgroundColor:
                      doc.alreadyRead == false ? primaryLita : Colors.grey,
                  child: Text(
                    '${doc.title.substring(0, 1)}',
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotifiactionDetailsPage(
                          notification: doc,
                        ),
                      ),
                    );
                    notificationprovider.markAsReadFc(doc.id);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${doc.title}',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 17,
                            color: doc.alreadyRead == false
                                ? accentLita
                                : Colors.grey),
                      ),
                      Text(
                        '${doc.description}',
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {},
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${doc.updatedAtFormat}',
                            style: GoogleFonts.sourceSansPro(fontSize: 9),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
