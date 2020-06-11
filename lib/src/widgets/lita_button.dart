import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';


class LitaBtn extends StatelessWidget {
  const LitaBtn({
    Key key,
    @required GlobalKey<FormBuilderState> fbKey,
    @required this.loginProvider,
  }) : _fbKey = fbKey, super(key: key);

  final GlobalKey<FormBuilderState> _fbKey;
  final LoginService loginProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .1),
      child: MaterialButton(
        onPressed: () async {
          if (_fbKey.currentState.saveAndValidate()) {
            loginProvider.email =
                _fbKey.currentState.value['email'];
            loginProvider.password =
                _fbKey.currentState.value['password'];
          bool login =  await loginProvider.loginUser();
          if(login==false){
            print('aqui');
            Alert.alert(context,title: 'Ocurrio un error, verifica el password',);
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
              ? CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 1,)
              : Text(
                  'Iniciar Sesión',
                  style: GoogleFonts.sourceSansPro(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
        ),
      ),
    );
  }
}
