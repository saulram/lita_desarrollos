import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';

import 'package:url_launcher/url_launcher.dart';

class ResidentsCard extends StatelessWidget {
  final String completeName, address, phone;

  const ResidentsCard({this.completeName, this.address, this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: CircleAvatar(
              backgroundColor: Colors.red,
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
                Text('$address')
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
                    print('tapp');
                   _launchURL();
                  },
                  child: Column(
                    children: <Widget>[
                      ImageIcon(
                        AssetImage('assets/mobile.png'),
                        color: accentLita,
                      ),
                      Text(
                        'Llamar',
                        style: GoogleFonts.sourceSansPro(fontSize: 10),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      ImageIcon(
                        AssetImage('assets/msgbu.png'),
                        color: accentLita,
                      ),
                      Text(
                        'Mensaje',
                        style: GoogleFonts.sourceSansPro(fontSize: 10),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  _launchURL() async {
    final  url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}