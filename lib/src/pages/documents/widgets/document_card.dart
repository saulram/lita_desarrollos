
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/document_list_model.dart';
import 'package:litadesarrollos/src/pages/documents/document_content_page.dart';

import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';

import 'package:url_launcher/url_launcher.dart';

class DocCard extends StatelessWidget {
  final Document doc;

  const DocCard({this.doc});

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
                child: CircleAvatar(
                  backgroundColor: primaryLita,
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
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DocumentDetails(
                      doc: doc,
                    )));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${doc.title}',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 18, color: accentLita),
                      ),
                      Text('${doc.content}',maxLines: 2,),
                      Text(
                        '${doc.updatedAtFormat}',
                        style:
                            GoogleFonts.sourceSansPro(color: HexColor('#828282')),
                      )
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
                      onTap: () async {

                        _launchURL();
                      },
                      child: Column(
                        children: <Widget>[
                          ImageIcon(
                            AssetImage('assets/cliud.png'),
                            color: accentLita,
                          ),
                          Text(
                            'Descargar',
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
        ],
      ),
    );
  }

  _launchURL() async {
    final url = '${doc.documentUrl}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
