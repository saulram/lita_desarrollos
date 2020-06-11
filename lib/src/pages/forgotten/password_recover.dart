import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  //controlador de formulario

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginService>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
      ),
      backgroundColor: primaryLita,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: FormBuilder(
            key: loginProvider.fbRecover,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .05),
                  child: Center(
                    child: Image.asset(
                      'assets/lita.png',
                      width: MediaQuery.of(context).size.width * .25,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * .05),
                  child: Text(
                    'Olvidé mi contraseña',
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .01,horizontal: 20),
                  child: Text(
                    '''Se enviará a tu mail un link donde podrás obtener una nueva contraseña.''',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.white, fontSize: 16),
                  ),
                ),

                /**
                 * Text Field para usuario, email
                 */
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .1,
                      vertical: MediaQuery.of(context).size.height * .04),
                  child: FormBuilderTextField(
                    style: GoogleFonts.sourceSansPro(
                        color: Colors.white, fontSize: 16),
                    attribute: "email",
                    autocorrect: false,
                    textInputAction: TextInputAction.done,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        labelText: "Email de recuperación",
                        labelStyle: GoogleFonts.sourceSansPro(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        errorStyle: TextStyle(color: accentLita),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white))),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .35,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (loginProvider.fbRecover.currentState
                        .saveAndValidate()) {
                      loginProvider.email =
                          loginProvider.fbRecover.currentState.value["email"];
                      bool finish = await loginProvider.passRecover();
                      if (finish == true) {
                        Alert.alert(context,
                            title: "Cambiar Contraseña",
                            content:
                                "Revisa tu email para continuar con el proceso",
                          ok: 'Entendido',
                          barrierDismissible: false,
                        );
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: accentLita,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .2),
                    child: loginProvider.isloading == true
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 1,
                          )
                        : Text(
                            'Recuperar Contraseña',
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
