import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/pages/inicio/services/preference_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class PreferenceSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final preferenceService = Provider.of<PrefService>(context);

    final User user = preferenceService.loginResult.user;
    final loginService = Provider.of<LoginService>(context);

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
            height: MediaQuery.of(context).size.height * .05,
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
                    '''Selecciona los modulos que quieras que aparezcan
    en tu página de inicio para un fácil acceso.
    Tienes un máximo de 6 opciones.''',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .05),
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
                              CheckboxListTile(
                                title: Text(
                                  'Áreas Comunes',
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.white),
                                ),
                                value: preferenceService.categories
                                    .contains('Common'),
                                onChanged: (bool selected) {
                                  preferenceService.onCategorySelected(
                                      selected, 'Common', context);
                                },
                                checkColor: primaryLita,
                                activeColor: Colors.white,
                              ),
                              CheckboxListTile(
                                title: Text(
                                  'Encuestas y Votaciones',
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.white),
                                ),
                                value: preferenceService.categories
                                    .contains('Vote'),
                                onChanged: (bool selected) {
                                  preferenceService.onCategorySelected(
                                      selected, 'Vote', context);
                                },
                                checkColor: primaryLita,
                                activeColor: Colors.white,
                              ),
                              CheckboxListTile(
                                title: Text(
                                  'Avisos',
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.white),
                                ),
                                value: preferenceService.categories
                                    .contains('Avisos-page'),
                                onChanged: (bool selected) {
                                  preferenceService.onCategorySelected(
                                      selected, 'Avisos-page', context);
                                },
                                checkColor: primaryLita,
                                activeColor: Colors.white,
                              ),
                              CheckboxListTile(
                                title: Text(
                                  'Objetos perdidos y encontrados',
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.white),
                                ),
                                value: preferenceService.categories
                                    .contains('Lost'),
                                onChanged: (bool selected) {
                                  preferenceService.onCategorySelected(
                                      selected, 'Lost', context);
                                },
                                checkColor: primaryLita,
                                activeColor: Colors.white,
                              ),
                              CheckboxListTile(
                                title: Text(
                                  'Bazar',
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.white),
                                ),
                                value: preferenceService.categories
                                    .contains('Bazar'),
                                onChanged: (bool selected) {
                                  preferenceService.onCategorySelected(
                                      selected, 'Bazar', context);
                                },
                                checkColor: primaryLita,
                                activeColor: Colors.white,
                              ),
                              CheckboxListTile(
                                title: Text(
                                  'Mantenimiento y quejas',
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.white),
                                ),
                                value: preferenceService.categories
                                    .contains('Mantenimiento'),
                                onChanged: (bool selected) {
                                  preferenceService.onCategorySelected(
                                      selected, 'Mantenimiento', context);
                                },
                                checkColor: primaryLita,
                                activeColor: Colors.white,
                              ),
                            ],
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Directorio',
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            value: preferenceService.categories
                                .contains('Directorio'),
                            onChanged: (bool selected) {
                              preferenceService.onCategorySelected(
                                  selected, 'Directorio', context);
                            },
                            checkColor: primaryLita,
                            activeColor: Colors.white,
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Chat',
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            value:
                                preferenceService.categories.contains('Chat'),
                            onChanged: (bool selected) {
                              preferenceService.onCategorySelected(
                                  selected, 'Chat', context);
                            },
                            checkColor: primaryLita,
                            activeColor: Colors.white,
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Estado de cuenta',
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            value: preferenceService.categories
                                .contains('Account'),
                            onChanged: (bool selected) {
                              preferenceService.onCategorySelected(
                                  selected, 'Account', context);
                            },
                            checkColor: primaryLita,
                            activeColor: Colors.white,
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Visitas programadas',
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            value: preferenceService.categories
                                .contains('Visitas-Programadas'),
                            onChanged: (bool selected) {
                              preferenceService.onCategorySelected(
                                  selected, 'Visitas-Programadas', context);
                            },
                            checkColor: primaryLita,
                            activeColor: Colors.white,
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Documentos',
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            value: preferenceService.categories
                                .contains('Documents-page'),
                            onChanged: (bool selected) {
                              preferenceService.onCategorySelected(
                                  selected, 'Documents-page', context);
                            },
                            checkColor: primaryLita,
                            activeColor: Colors.white,
                          ),
                          CheckboxListTile(
                            title: Text(
                              'Beneficios Lita',
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            value: preferenceService.categories
                                .contains('Benefits'),
                            onChanged: (bool selected) {
                              preferenceService.onCategorySelected(
                                  selected, 'Benefits', context);
                            },
                            checkColor: primaryLita,
                            activeColor: Colors.white,
                          ),
                          Divider(),
                          Center(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                              color: primaryLita,
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width *.2),
                                  child: preferenceService.loading== true ? CircularProgressIndicator(): Text(
                                    'Listo',
                                    style: GoogleFonts.sourceSansPro(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                                onPressed: ()async  {
                                LoginResult newLr = await preferenceService.updateScreenPreferences();
                                if(newLr!= null){
                                  loginService.loginResult = newLr;
                                  Navigator.pop(context);
                                }
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
