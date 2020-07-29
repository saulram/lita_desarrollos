import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/theme/theme.dart';

class ReportDonePage extends StatelessWidget {
  final String rn;

  const ReportDonePage({Key key, this.rn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryLita,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Reporte No. ${rn.toUpperCase()}',
              textAlign: TextAlign.center,
              style: GoogleFonts.sourceSansPro(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: Text(
                      'Tu reporte ha sido enviado con éxito a la administracion.\n En breve nos pondremos en contacto contigo.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white))),
            ),
            OutlineButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
              borderSide: BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.2),
                child: Text('Entendido',style: GoogleFonts.sourceSansPro(color: Colors.white),),
              ),
            ),
          ],
        ));
  }
}
