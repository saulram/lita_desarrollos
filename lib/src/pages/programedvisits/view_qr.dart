import 'dart:convert';

import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/programedvisits/services/visits_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:native_screenshot/native_screenshot.dart';
import 'package:provider/provider.dart';

class ViewQR extends StatelessWidget {
  final String code,codeUrl;

  const ViewQR({Key key, this.code, this.codeUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visitProvider = Provider.of<VisitService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              CupertinoIcons.clear,
              size: 30,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
        elevation: 0,
        title: Text(
          'Código QR',
          style: GoogleFonts.sourceSansPro(color: Colors.white),
        ),
      ),
      backgroundColor:
      HexColor(visitProvider.user.user.residency.theme.secondaryColor),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Image.memory(
                base64Decode(
                    codeUrl.split(',').last),
                width: MediaQuery.of(context).size.width * .8,
                height: MediaQuery.of(context).size.width * .8,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              '${code.toUpperCase()}',
              style: GoogleFonts.sourceSansPro(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
            MaterialButton(
              onPressed: () async {
                String path = await NativeScreenshot.takeScreenshot();
                if (path != null) {
                  Alert.alert(
                    context,
                    title: "Exito",
                    content: "La imagen se guardo en tus fotos.",
                    ok: 'Entendido',
                    barrierDismissible: false,
                  );
                } else {
                  Alert.alert(
                    context,
                    title: "Error",
                    content:
                    "No pudimos guardar la imagen. Por favor activa los permisos en ajustes de tu dispositivo.",
                    ok: 'Entendido',
                    barrierDismissible: false,
                  );
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color:
              HexColor(visitProvider.user.user.residency.theme.mainColor),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: MediaQuery.of(context).size.width * .2),
                child: Text(
                  'Guardar',
                  style: GoogleFonts.sourceSansPro(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
