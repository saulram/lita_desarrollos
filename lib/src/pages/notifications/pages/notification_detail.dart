import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/notifications_list_model.dart';
import 'package:litadesarrollos/src/theme/theme.dart';

class NotifiactionDetailsPage extends StatelessWidget {
  final Notify notification;

  const NotifiactionDetailsPage({Key key, this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLita,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          '${notification.title}',
          style: GoogleFonts.sourceSansPro(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              notification.description,
              style:
                  GoogleFonts.sourceSansPro(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: notification.customFields.map<Widget>((elment) {
                  return Column(
                    children: <Widget>[
                      Text(
                        elment.label,
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        elment.value,
                        style: GoogleFonts.sourceSansPro(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                }).toList()),
            OutlineButton(
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              borderSide: BorderSide(color: Colors.white),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .2),
                child: Text(
                  'Entendido',
                  style: GoogleFonts.sourceSansPro(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
