import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class PreferenceSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);

    final User user = loginService.loginResult.user;

    return Scaffold(
        backgroundColor: HexColor(user.residency.theme.secondaryColor),
        drawerScrimColor: Colors.transparent,
        endDrawer: DrawerLita(),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.white),
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
        body: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    'Personaliza tu pantalla',
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '''Selecciona las secciones que quieras que aparezcan
    en tu página de inicio para un fácil acceso.
    Tienes un máximo de 6 opciones.''',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.05),
                      child: ListView(
                        children: <Widget>[
                          ExpansionTile(
                            key: Key(''),
                            title: Text(
                              'Comunidad',
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            trailing: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            children: [
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05),
                                child: Container(

                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width * .5,
                                        child: Text(
                                          'Áreas Comunes',
                                          style: GoogleFonts.sourceSansPro(
                                              color: Colors.white, fontSize: 17),
                                        ),
                                      ),
                                      Radio(
                                        onChanged: (value) {},
                                        groupValue: '',
                                        value: 'opc 1',
                                        activeColor: HexColor(
                                            user.residency.theme.mainColor),
                                      )
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.symmetric(vertical: BorderSide(color: HexColor(user.residency.theme.thirdColor)))
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05),
                                child: Container(

                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width * .5,
                                        child: Text(
                                          'Áreas Comunes',
                                          style: GoogleFonts.sourceSansPro(
                                              color: Colors.white, fontSize: 17),
                                        ),
                                      ),
                                      Radio(
                                        onChanged: (value) {},
                                        groupValue: '',
                                        value: 'opc 1',
                                        activeColor: HexColor(
                                            user.residency.theme.mainColor),
                                      )
                                    ],
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.symmetric(vertical: BorderSide(color: HexColor(user.residency.theme.thirdColor)))
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05),
                                child: Container(

                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width * .5,
                                        child: Text(
                                          'Áreas Comunes',
                                          style: GoogleFonts.sourceSansPro(
                                              color: Colors.white, fontSize: 17),
                                        ),
                                      ),
                                      Radio(
                                        onChanged: (value) {},
                                        groupValue: '',
                                        value: 'opc 1',
                                        activeColor: HexColor(
                                            user.residency.theme.mainColor),
                                      )
                                    ],
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.symmetric(vertical: BorderSide(color: HexColor(user.residency.theme.thirdColor)))
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.05),
                                child: Container(

                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width:
                                        MediaQuery.of(context).size.width * .5,
                                        child: Text(
                                          'Áreas Comunes',
                                          style: GoogleFonts.sourceSansPro(
                                              color: Colors.white, fontSize: 17),
                                        ),
                                      ),
                                      Radio(
                                        onChanged: (value) {},
                                        groupValue: '',
                                        value: 'opc 1',
                                        activeColor: HexColor(
                                            user.residency.theme.mainColor),
                                      )
                                    ],
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.symmetric(vertical: BorderSide(color: HexColor(user.residency.theme.thirdColor)))
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
