import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/bottom_lita.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';

import 'package:litadesarrollos/src/widgets/init_square.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);

    final User user = loginService.loginResult.user;

    return Scaffold(
      backgroundColor: HexColor(user.residency.theme.secondaryColor),
      drawerScrimColor: Colors.transparent,
      endDrawer:DrawerLita(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: HexColor(user.residency.theme.secondaryColor),
        title: Image.asset(
          'assets/lita.png',
          width: MediaQuery.of(context).size.width * .23,
        ),
        elevation: 0,
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Personaliza tu pantalla',
                      style: GoogleFonts.sourceSansPro(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * .07),
                      child: Text(
                        'Editar',
                        style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 17),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 16 / 12,
                      crossAxisCount: 2),
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    int lgt = user.screenPreferences.length;

                    if (index < lgt) {
                      return SqarePrefs(
                        color: HexColor(user.residency.theme.thirdColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                                "assets/secciones/icon_${user.screenPreferences[index]}.png"),
                            Text(
                              user.screenPreferences[index],
                              style: GoogleFonts.sourceSansPro(
                                  fontSize: 17,
                                  color: HexColor(
                                      user.residency.theme.secondaryColor)),
                            )
                          ],
                        ),
                      );
                    } else {
                      return SqarePrefs(
                        child: MaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, 'preferences-section');
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.add_circle_outline,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Agregar sección',
                                        style: GoogleFonts.sourceSansPro(
                                            color: HexColor(user
                                                .residency.theme.thirdColor)),
                                      )
                                    ],
                                  ),
                                ])),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar:BottomLita(),
    );
  }
}
