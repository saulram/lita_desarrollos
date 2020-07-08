import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/addedobject_model.dart';
import 'package:litadesarrollos/src/pages/lost_found/services/lost_found_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class LostFinal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lostService = Provider.of<LostService>(context);
    return Scaffold(
      backgroundColor: HexColor(lostService.loginResult.user.residency.theme.mainColor),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(),
            Text('Tu objeto ha sido publicado con éxito',style: GoogleFonts.sourceSansPro(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
            CircleAvatar(
              backgroundImage: NetworkImage(lostService.objUploaded.addLostObject.fullFiles[0]),
              radius: MediaQuery.of(context).size.width*.4,
            ),
            OutlineButton(
              onPressed: () {

                Navigator.pop(context);
                lostService.objUploaded=AddedObj();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              borderSide: BorderSide(color: Colors.white),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .2),
                child: Text(
                  'Entendido',
                  style: GoogleFonts.sourceSansPro(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
