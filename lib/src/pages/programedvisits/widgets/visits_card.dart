import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/programedvisits/view_qr.dart';

import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';

class VisitsCard extends StatelessWidget {
  final String completeName, type, code, codeUrl, date,until;

  const VisitsCard(
      {this.completeName, this.type, this.code, this.codeUrl, this.date, this.until});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: CircleAvatar(
              backgroundColor: primaryLita,
              child: Text(
                '${completeName.substring(0, 1).toUpperCase()}',
                style: GoogleFonts.sourceSansPro(
                    color: Colors.white, fontSize: 22),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$completeName',
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 18, color: HexColor('#333333')),
                ),
                Text(
                  'Tipo de visita: $type',
                  style: GoogleFonts.sourceSansPro(),
                ),
                Text('$date',style: GoogleFonts.sourceSansPro(),),
                Text('$until',style: GoogleFonts.sourceSansPro(),),

              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewQR(
                                  code: code,
                                  codeUrl: codeUrl,
                                )));
                  },
                  child: Column(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.qrcode,
                        color: accentLita,
                      ),
                      Text(
                        'Ver QR',
                        style: GoogleFonts.sourceSansPro(fontSize: 10),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
