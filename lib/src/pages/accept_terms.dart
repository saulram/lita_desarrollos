import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/services/graphql_terms_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class AcceptTerms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);
    final terminos = Provider.of<TermsService>(context);
    final User user = loginService.loginResult.user;

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        backgroundColor: HexColor(
            user != null ? user.residency.theme.secondaryColor : '#ffffff'),
        elevation: 0,
        title: Text(
          'Terminos y Condiciones',
          style: GoogleFonts.sourceSansPro(color: Colors.white),
        ),

      ),
      backgroundColor: user != null
          ? HexColor(user.residency.theme.secondaryColor)
          : Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: terminos.terminos.globalContent != null
                    ? SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            terminos.terminos.globalContent != null
                                ? terminos.terminos.globalContent.content + ''
                                : '',
                            style: GoogleFonts.sourceSansPro(
                              color: HexColor(user != null
                                  ? user.residency.theme.thirdColor
                                  : '#fffffff'),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                    )
                    : Center(
                        child: CircularProgressIndicator(
                          backgroundColor: HexColor(
                            user.residency.theme.mainColor,
                          ),
                          strokeWidth: 1,
                        ),
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .1),
                child: MaterialButton(
                  onPressed: () async {
                   bool done = await terminos.termsAccepted();
                      if(done ==   true){
                        loginService.loginResult = LoginResult();
                        loginService.loginUser();
                      }


                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: HexColor(user.residency.theme.mainColor),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .2),
                    child: loginService.isloading == true
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 1,
                          )
                        : Text(
                            'Aceptar',
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
