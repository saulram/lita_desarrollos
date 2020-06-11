import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/document_list_model.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class DocumentDetails extends StatelessWidget {
  final Document doc;

  const DocumentDetails({Key key, this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<LoginService>(context);
    return Scaffold(
      backgroundColor: HexColor(userService.loginResult.user.residency.theme.secondaryColor),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:HexColor(userService.loginResult.user.residency.theme.secondaryColor) ,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: Colors.white),
        title: Text(doc.title,style: GoogleFonts.sourceSansPro(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.all(MediaQuery.of(context).size.width*.1),
            child: Text(
                doc.content,style: GoogleFonts.sourceSansPro(color: Colors.white),textAlign: TextAlign.justify,
            ),
          ),
          MaterialButton(
            color: HexColor(userService.loginResult.user.residency.theme.mainColor),
            onPressed: (){
              Navigator.of(context).pop();
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.2),
              child: Text(
                'Entendido',style: GoogleFonts.sourceSansPro(color: Colors.white),
              ),
            ),
          )

        ],
      ),
    );
  }
}
