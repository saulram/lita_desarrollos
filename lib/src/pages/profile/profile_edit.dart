import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/pages/inicio/services/preference_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginService>(context);

    final initialService = Provider.of<PrefService>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Editar perfil',
          style: GoogleFonts.sourceSansPro(),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'profile',
                child: CircleAvatar(
                  backgroundColor: HexColor(loginProvider
                      .loginResult.user.residency.theme.secondaryColor),
                  child: Padding(
                    padding:
                        EdgeInsets.all(MediaQuery.of(context).size.width * .02),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                                loginProvider.loginResult.user.fullFile),
                          )),
                    ),
                  ),
                  radius: MediaQuery.of(context).size.width * .15,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .05, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Nombre',
                        style: GoogleFonts.sourceSansPro(
                            color: HexColor('#828282'), fontSize: 16),
                      ),
                    ),
                    Row(
                      children: [],
                    ),
                    Container(
                      child: Text(
                        '${loginProvider.loginResult.user.completeName}',
                        style: GoogleFonts.sourceSansPro(
                            color: HexColor('#333333'), fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .05, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Departamento o casa',
                        style: GoogleFonts.sourceSansPro(
                            color: HexColor('#828282'), fontSize: 16),
                      ),
                    ),
                    Row(
                      children: [],
                    ),
                    Container(
                      child: Text(
                        '${loginProvider.loginResult.user.residency.name}',
                        style: GoogleFonts.sourceSansPro(
                            color: HexColor('#333333'), fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .05,
                    left: 10,
                    right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage('assets/mobile.png'),
                          color: accentLita,
                        ),
                        Text(
                          '${loginProvider.loginResult.user.phone}',
                          style: GoogleFonts.sourceSansPro(
                              color: HexColor('#333333'), fontSize: 18),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                      LoginResult lr = await  initialService.updateScreenPreferences(isActive: !loginProvider.loginResult.user.isPhoneActive);
                      if(lr.user != null){
                        int i = await Alert.alert(context, title:'Perfil actualizado');
                        if(i == 0 ){
                          loginProvider.loginUser();
                          print('Reiniciamos sesion');
                        }
                      }
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(
                            loginProvider.loginResult.user.isPhoneActive == true
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            color: accentLita,
                          ),
                          Text(
                            loginProvider.loginResult.user.isPhoneActive == true
                                ? '  Ocultar mi numero'
                                : '  Mostrar mi número',
                            style: GoogleFonts.sourceSansPro(color: accentLita),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .05,
                    left: 10,
                    right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.envelope,
                          color: accentLita,
                        ),
                        Text(
                          ' ${loginProvider.loginResult.user.email}',
                          style: GoogleFonts.sourceSansPro(
                              color: HexColor('#333333'), fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .07,
              ),
              Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Mis datos no son correctos',
                      style: GoogleFonts.sourceSansPro(color: accentLita),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
