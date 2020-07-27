import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';

import 'package:url_launcher/url_launcher.dart';

class PersonalCard extends StatelessWidget {
  final String completeName, address, phone,description,horario,file;

  const PersonalCard({this.completeName, this.address, this.phone, this.description, this.horario,this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(file),
                    backgroundColor: Colors.white,
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
                          fontSize: 18, color: accentLita),
                      maxLines: 2,
                    ),
                    Text('$address'),
                    Text(
                      '$horario',
                      style:
                          GoogleFonts.sourceSansPro(color: HexColor('#828282')),
                    )
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
                      onTap: () {
                        Navigator.pushReplacementNamed(context, 'Chat');
                      },
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
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 5,
                child: Container(child: Text('$description',style: GoogleFonts.sourceSansPro(),textAlign: TextAlign.left,maxLines: 2,)),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              )
            ],
          )
        ],
      ),
    );
  }

  _launchURL() async {
    final url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
