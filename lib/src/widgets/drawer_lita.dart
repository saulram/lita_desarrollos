
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/services/login_service.dart';

import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class DrawerLita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);
    final user = loginService.loginResult.user;
    return Drawer(
      elevation: 0,
      child: Container(
        color: HexColor(user.residency.theme.mainColor),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.clear,
                      color: Colors.white,
                      size: 50,
                    ),
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      loginService.deleteAllUserData();


                    },
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * .08,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: CircleAvatar(
                                backgroundColor:
                                    HexColor(user.residency.theme.thirdColor),
                                backgroundImage: NetworkImage(user.fullFile),
                                radius: MediaQuery.of(context).size.width * .08,
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        .05,
                                    left: MediaQuery.of(context).size.width *
                                        .09),
                                child: Container(
                                    padding: EdgeInsets.all(2),
                                    height: MediaQuery.of(context).size.width *
                                        .075,
                                    width: MediaQuery.of(context).size.width *
                                        .075,
                                    decoration: BoxDecoration(
                                        color: HexColor(user
                                            .residency.theme.secondaryColor),
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Icon(
                                        CupertinoIcons.pencil,
                                        color: Colors.white,
                                        size: 13,
                                      ),
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: Text(
                        '${user.completeName} ',
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, 'Directorio');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * .04,
                      width: MediaQuery.of(context).size.width * .5,
                      child: Text(
                        'Directorio',
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .04,
                      child: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, 'Visitas-Programadas');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .5,
                      height: MediaQuery.of(context).size.height * .04,
                      child: Text(
                        'Visitas Programadas',
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .04,
                      child: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, 'Mantenimiento');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .5,
                      height: MediaQuery.of(context).size.height * .04,
                      child: Text(
                        'Mantenimiento',
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .04,
                      child: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context,'Avisos-page');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .5,
                      height: MediaQuery.of(context).size.height * .04,
                      child: Text(
                        'Avisos',
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .04,
                      child: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context,'Documents-page');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .5,
                      height: MediaQuery.of(context).size.height * .04,
                      child: Text(
                        'Documentos',
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .04,
                      child: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context,'Vote');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .5,
                      height: MediaQuery.of(context).size.height * .04,
                      child: Text(
                        'Votaciones',
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .04,
                      child: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context,'Common');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .5,
                      height: MediaQuery.of(context).size.height * .04,
                      child: Text(
                        'Áreas comunes',
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .04,
                      child: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context,'Lost');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * .5,
                      height: MediaQuery.of(context).size.height * .04,
                      child: Text(
                        'Objetos',
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .04,
                      child: Icon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
