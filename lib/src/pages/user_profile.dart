import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';

class UserProfile extends StatelessWidget {
  final User user;
  final String color;

  const UserProfile({Key key, this.user, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          user.completeName,
          style: GoogleFonts.sourceSansPro(
              fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: HexColor(color),
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * .02),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(user.fullFile),
                      )),
                ),
              ),
              radius: MediaQuery.of(context).size.width * .15,
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Puesto',
                      style: GoogleFonts.sourceSansPro(
                          color: HexColor('#828282'), fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [],
                  ),
                  Container(
                    child: Text(
                      '${user.residency}',
                      style: GoogleFonts.sourceSansPro(
                          color: HexColor('#333333'), fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, left: 8),
              child: Row(
                children: <Widget>[
                  ImageIcon(
                    AssetImage('assets/mobile.png'),
                    color: accentLita,
                  ),
                  Text(
                    '${user.phone}',
                    style: GoogleFonts.sourceSansPro(
                        color: HexColor('#333333'), fontSize: 18),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .22,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05, left: 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Descripcion',
                        style: GoogleFonts.sourceSansPro(
                            color: HexColor('#828282'), fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Text(
                        '${user.departmentId}',
                        style: GoogleFonts.sourceSansPro(
                            color: HexColor('#333333'), fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
