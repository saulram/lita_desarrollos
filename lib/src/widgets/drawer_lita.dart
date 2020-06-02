import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
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
                      loginService.deleteAllUserData();
                      loginService.loginResult = LoginResult();
                    },
                  )
                ],
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .08,
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
                                radius: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .08,
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        .05,
                                    left: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        .09),
                                child: Container(
                                    padding: EdgeInsets.all(2),
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        .075,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
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
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .02,
              ),
              ExpansionTile(
                backgroundColor: HexColor(user.residency.theme.mainColor),
                trailing: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                title: Text(
                  'Directorio',
                  style: GoogleFonts.sourceSansPro(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.popAndPushNamed(context, 'Directorio');

                    },
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .04,

                      child: Center(
                        child: Text(
                          'Directorio de Inquilinos',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
