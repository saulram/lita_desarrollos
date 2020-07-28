import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/pages/notifications/main_notification_page.dart';
import 'package:litadesarrollos/src/pages/wall/wall_main.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/bottom_lita.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';

import 'package:litadesarrollos/src/widgets/init_square.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);

    final User user = loginService.loginResult.user;

      switch(loginService.pageView){
        case 0:{
          return Scaffold(
            backgroundColor: HexColor(user.residency.theme.secondaryColor),
            drawerScrimColor: Colors.transparent,
            endDrawer: DrawerLita(),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: HexColor(user.residency.theme.secondaryColor),
              title: Padding(
                padding: const EdgeInsets.all(9),
                child: Image.asset(
                  'assets/lita.png',
                  width: MediaQuery.of(context).size.width * .23,

                ),
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
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(
                                  context, 'preferences-section');
                            },
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
                            return InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed(loginService.loginResult.user.screenPreferences[index]);
                              },
                              child: SqarePrefs(
                                color: HexColor(user.residency.theme.thirdColor),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ImageIcon(
                                      AssetImage(
                                          "assets/sections/${user.screenPreferences[index]}.png"),
                                      color:
                                      HexColor(user.residency.theme.secondaryColor),
                                      size: MediaQuery.of(context).size.width * .15,
                                    ),
                                    Text(
                                      this.translateString(
                                          user.screenPreferences[index]),
                                      style: GoogleFonts.sourceSansPro(
                                          fontSize: 17,
                                          color: HexColor(
                                              user.residency.theme.secondaryColor)),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
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
            bottomNavigationBar: BottomLita(),
          );
        }
        case 1:{
          return WallMainPage();
        }
        default:
          {
            return NotificationsPage();
          }
      }



  }


  String translateString(String s) {
    switch (s) {
      case 'Account':
        return 'Estados de Cuenta';
      case 'Benefits':
        return 'Beneficios';
      case 'Visitas-Programadas':
        return 'Visitas programadas';
      case 'Documents-page':
        return 'Documentos';
      case 'Vote':
        return 'Encuestas y votaciones';
      case 'Lost':
        return 'Objetos perdidos y encontrados';
      case 'Avisos-page':
        return 'Avisos';
      case 'Common':
        return 'Áreas comunes';
      case 'Mantenimiento':
        return 'Mantenimiento y quejas';
      default:
        return s;
    }
  }
}
