import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/categories_bazar_model.dart';
import 'package:litadesarrollos/src/pages/bazaar/pages/bazzar_comments.dart';
import 'package:litadesarrollos/src/pages/bazaar/services/bazaar_service.dart';

import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BazaarDetail extends StatelessWidget {
  final Bazaar  object ;

  const BazaarDetail({Key key, this.object}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formatCurrency = new NumberFormat.simpleCurrency();


    final loginProvider = Provider.of<LoginService>(context);
    final bazarService = Provider.of<BazaarService>(context);

    return loginProvider.loginResult.user != null
        ? Scaffold(
      endDrawer: DrawerLita(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Bazar',
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
            Stack(
              children: <Widget>[

                Image.network(object.fullFiles[0],fit: BoxFit.cover,width: MediaQuery.of(context).size.width,),
                Positioned(
                  bottom: 0,
                  left: 20,
                  child: Container(
                    color: primaryLita,
                    height: MediaQuery.of(context).size.height*.05,
                    width: MediaQuery.of(context).size.width*.2,
                    child: Center(
                      child: Text('${object.type.toUpperCase()}',style: GoogleFonts.sourceSansPro(color: Colors.white),),
                    ),


                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    bazarService.getComments(object.id);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BazaarComments(bazaarId: object.id,)));

                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: <Widget>[
                        ImageIcon(AssetImage('assets/comment.png'),),
                        Text('Comentarios',style: GoogleFonts.sourceSansPro(),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Publicado: ${object.formatDate}',style: GoogleFonts.sourceSansPro(color: HexColor('#333333',),fontSize: 12),)
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${formatCurrency.format(object.price)} MXN',style: GoogleFonts.sourceSansPro(fontSize: 18,fontWeight: FontWeight.w600),),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${object.description}',style: GoogleFonts.sourceSansPro(fontSize: 16,fontWeight: FontWeight.w400),),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(object.postedByUser.fullFile),

                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text('Publicado por: ${object.postedByUser.completeName}',style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.w300),),
                    )

                  ],
                )
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*.1,
            ),
            Center(
              child: CupertinoButton(
                color: accentLita,
                onPressed: (){
                  Navigator.of(context).pushNamed('Chat');


                },
                child: Text('Me interesa'),

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
