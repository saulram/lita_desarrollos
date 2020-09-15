import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/lost_found/screens/create_found.dart';
import 'package:litadesarrollos/src/pages/lost_found/services/lost_found_service.dart';
import 'package:litadesarrollos/src/pages/lost_found/tabs/detail_found.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:provider/provider.dart';

class FoundTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lostService = Provider.of<LostService>(context);
    return Stack(
      children: <Widget>[
        Container(

          child: Container(
            height: MediaQuery.of(context).size.height*.15,
            color: primaryLita,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * .02),
            child: Column(
              children: <Widget>[
               lostService.loginResult.user.roles[0]!='resident'? Container(): Text(
                  '¿Has encontrado algún objeto? \n  Publícalo aquí para encontrar a su dueño. ¡Gracias!',
                  style: GoogleFonts.sourceSansPro(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
               lostService.loginResult.user.roles[0]!='resident'?Container(): InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateFound()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add_circle,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Subir un objeto',
                          style: GoogleFonts.sourceSansPro(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top:lostService.loginResult.user.roles[0]!='resident'? MediaQuery.of(context).size.height*.02: MediaQuery.of(context).size.height*.11,
          child: Container(
            height: MediaQuery.of(context).size.height*.6,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 20.0,

                ),
                itemCount: lostService.found.lostObjects!=null? lostService.found.lostObjects.length:0,
                itemBuilder: (BuildContext ctx, int i) {

                    return GestureDetector(
                      onTap: (){
                        print(lostService.found.lostObjects[i].fullFiles[0]);
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FoundDetail(object:lostService.found.lostObjects[i])));

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(),
                            AspectRatio(
                                aspectRatio: 4 / 3,
                                child: lostService.found.lostObjects[i].fullFiles.length>0 ? Image.network(
                                  lostService.found.lostObjects[i].fullFiles[0],fit: BoxFit.cover,):Container()),
                            Text('${lostService.found.lostObjects[i].name}',style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.w600),textAlign: TextAlign.start,),
                            Text('${lostService.found.lostObjects[i].looseAtFormatDate}',style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.w400,fontSize: 10),textAlign: TextAlign.start,),

                          ],
                        ),
                      ),
                    );
                  }),
          ),
        )
      ],
    );
  }
}
