import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/terms_model.dart';
import 'package:litadesarrollos/src/pages/accept_terms.dart';
import 'package:litadesarrollos/src/pages/common_areas/commonAreaAdmin.dart';
import 'package:litadesarrollos/src/pages/inicio/services/preference_service.dart';
import 'package:litadesarrollos/src/pages/profile/profile_edit.dart';
import 'package:litadesarrollos/src/pages/wall/legal.dart';
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
      child: user == null ? Container() :Container(
        color: HexColor(user.residency.theme.mainColor),
        child: SafeArea(
          child: SingleChildScrollView(
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
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .08,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => MyProfile()));
                          },
                          child: Container(
                            child: Stack(
                              children: <Widget>[
                                Center(
                                  child: Hero(
                                    tag: 'profile',
                                    child: CircleAvatar(
                                      backgroundColor: HexColor(
                                          user.residency.theme.thirdColor),
                                      backgroundImage:
                                          NetworkImage(user.fullFile),
                                      maxRadius:32


                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                .05,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                .09),
                                    child: Container(
                                        padding: EdgeInsets.all(2),
                                        height:
                                            MediaQuery.of(context).size.width *
                                                .075,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .075,
                                        decoration: BoxDecoration(
                                            color: HexColor(user.residency.theme
                                                .secondaryColor),
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
                ExpansionTile(
                  key: Key(''),
                  title: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .04),
                    child: Text(
                      'Comunidad',
                      style: GoogleFonts.sourceSansPro(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),
                  children: [
                    ListTile(
                      title: Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .1),
                        child: Text(
                          'Áreas comunes',
                          style: GoogleFonts.sourceSansPro(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        loginService.loginResult.user.roles[0] != 'resident'
                            ? Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => CommonAreaAdmin()))
                            : Navigator.of(context).pushNamed('Common');
                      },
                    ),
                    ListTile(
                      title: Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .1),
                        child: Text(
                          'Votaciones y encuestas',
                          style: GoogleFonts.sourceSansPro(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('Vote');
                      },
                    ),
                    ListTile(
                      title: Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .1),
                        child: Text(
                          'Avisos',
                          style: GoogleFonts.sourceSansPro(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('Avisos-page');
                      },
                    ),
                    ListTile(
                      title: Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .1),
                        child: Text(
                          'Objetos perdidos y encontrados',
                          style: GoogleFonts.sourceSansPro(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('Lost');
                      },
                    ),
                    ListTile(
                      title: Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .1),
                        child: Text(
                          'Bazar',
                          style: GoogleFonts.sourceSansPro(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('Bazar');
                      },
                    ),
                    ListTile(
                      title: Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .1),
                        child: Text(
                          'Mantenimiento y quejas',
                          style: GoogleFonts.sourceSansPro(color: Colors.white),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed('Mantenimiento');
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'Directorio');
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * .07,

                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .09),
                        child: Text(
                          'Directorio',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'Chat');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(

                        height: MediaQuery.of(context).size.height * .07,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .09),
                        child: Text(
                          'Chat',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                loginService.loginResult.user.roles[0] != 'resident'
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(context, 'Account');
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(

                              height: MediaQuery.of(context).size.height * .07,
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * .09),
                              child: Text(
                                'Estados de cuenta',
                                style: GoogleFonts.sourceSansPro(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                loginService.loginResult.user.roles[0] != 'resident'
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, 'Visitas-Programadas');
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: MediaQuery.of(context).size.height * .07,
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * .09),
                                child: Text(
                                  'Visitas programadas',
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(context, 'Documents-page');
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width > 500 ? MediaQuery.of(context).size.width *.2: MediaQuery.of(context).size.width * .5,
                          height: MediaQuery.of(context).size.height * .07,
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .09),
                          child: Text(
                            'Documentos',
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, 'Benefits');
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * .07,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .09),
                        child: Text(
                          'Beneficios Lita',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                         Navigator.popUntil(context, (route) {
                          if(route.isFirst){
                            loginService.deleteAllUserData();
                          }
                          return route.isFirst;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Cerrar sesión',
                            style:
                                GoogleFonts.sourceSansPro(color: Colors.white),
                          ),
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Legal()));
                      },
                      child: Text(
                        'Legal',
                        style: GoogleFonts.sourceSansPro(color: Colors.white),
                      ),
                    )
                  ],
                ),

                Text('V1.0.4',style: GoogleFonts.sourceSansPro(fontSize: 9,color: Colors.white),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
