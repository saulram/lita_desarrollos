import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/common_area_list_model.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class RulesPage extends StatelessWidget {
  final CommonArea area;

  const RulesPage({Key key, this.area}) : super(key: key);
  _launchURL(String url) async {

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentLita,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Reglamento ${area.name}',style: GoogleFonts.sourceSansPro(color: Colors.white),),
      ),
      backgroundColor: accentLita,
      body: Column(
        children:<Widget>[
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width*.05)
            ,
            child: Text(
                area.regulationContent,
              style: GoogleFonts.sourceSansPro(color: Colors.white),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.2,),
          GestureDetector(
            onTap: (){
              _launchURL(area.regulationFileUrl);
            },
            child: Column(
              children: <Widget>[
                Image.asset('assets/Vector.png'),
                Text('Descargar Reglamento',style: GoogleFonts.sourceSansPro(color: Colors.white),)
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*.1,
          ),

          CupertinoButton(
            color: primaryLita,
            child: Text(
              'Entendido'
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          )


          

        ]
      ),
    );
  }
}
