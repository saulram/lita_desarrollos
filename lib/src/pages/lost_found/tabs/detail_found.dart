import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/lost_objects.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class FoundDetail extends StatelessWidget {
  final LostObject  object ;

  const FoundDetail({Key key, this.object}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginService>(context);


    return loginProvider.loginResult.user != null
        ? Scaffold(
      endDrawer: DrawerLita(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Objeto Encontrado',
          style: GoogleFonts.sourceSansPro(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: primaryLita,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${object.name}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sourceSansPro(color: Colors.white,fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
            Image.network(object.fullFiles[0],fit: BoxFit.cover,width: MediaQuery.of(context).size.width,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('Publicado: ${object.updatedAtFormatDate}',style: GoogleFonts.sourceSansPro(color: HexColor('#333333',),fontSize: 12),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${object.name}',style: GoogleFonts.sourceSansPro(fontSize: 18,fontWeight: FontWeight.w600),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${object.description}',style: GoogleFonts.sourceSansPro(fontSize: 16,fontWeight: FontWeight.w400),),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*.1,
            ),
            loginProvider.loginResult.user.roles[0]!='resident' ?Container(): Center(
              child: CupertinoButton(
                color: accentLita,
                onPressed: (){
                  Navigator.of(context).pushNamed('Chat');


                },
                child: Text('Contactar al administrador'),

              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*.1,
            ),


          ],
        ),
      ),
    )
        : Scaffold();
  }
}
