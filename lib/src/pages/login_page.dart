import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/services/login_service.dart';

import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/widgets/lita_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

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
      body: GestureDetector(
        onTap: () {},
        child: SafeArea(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _fbKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .05),
                    child: Center(
                      child: Image.asset('assets/lita.png'),
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
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        labelText: "Usuario",
                        labelStyle: GoogleFonts.sourceSansPro(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  /**
                   * Textfield Password
                   */
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .1,
                        vertical: MediaQuery.of(context).size.height * .04),
                    child: FormBuilderTextField(
                      style: GoogleFonts.sourceSansPro(
                          color: Colors.white, fontSize: 16),
                      attribute: "password",
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      cursorColor: Colors.white,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: "Contraseña",
                        labelStyle: GoogleFonts.sourceSansPro(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),

                  /**
                   * Olvide mi password
                   */
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .10),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Olvidé mi contraseña',
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: InkWell(
                            onTap: () {
                              loginProvider.rememberUser =
                                  !loginProvider.rememberUser;
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: loginProvider.rememberUser == true
                                      ? Colors.white
                                      : primaryLita,
                                  border: Border.all(color: Colors.white)),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: loginProvider.rememberUser
                                    ? Icon(
                                        Icons.check,
                                        size: 30.0,
                                        color: primaryLita,
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank,
                                        size: 30.0,
                                        color: Colors.transparent,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            'Recordar Usuario',
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  LitaBtn(fbKey: _fbKey, loginProvider: loginProvider)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
