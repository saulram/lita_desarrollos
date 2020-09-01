import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/lost_found/detail_lost.dart';
import 'package:litadesarrollos/src/pages/lost_found/screens/create_lost.dart';
import 'package:litadesarrollos/src/pages/lost_found/services/lost_found_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:provider/provider.dart';

class LostTab extends StatelessWidget {
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
            child:lostService.loginResult.user.roles[0]!='resident' ?Container(): Column(
              children: <Widget>[
                Text(
                  '¿Has perdido algún objeto? \n Publícalo aquí para poder ayudarte a encontrarlo',
                  style: GoogleFonts.sourceSansPro(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CreateLost1st()));
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
   top: lostService.loginResult.user.roles[0]!='resident'? MediaQuery.of(context).size.height*.02: MediaQuery.of(context).size.height*.11,
          child: Container(
            height: MediaQuery.of(context).size.height*.6,
            width: MediaQuery.of(context).size.width,

            child: lostService.isloading == true? Center(child: CircularProgressIndicator(),): RefreshIndicator(
              onRefresh: lostService.getObjects,
              child: GridView.builder(
                  shrinkWrap: true,
                  cacheExtent: MediaQuery.of(context).size.height*.2,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: 3/4

                  ),
                  itemCount: lostService.objects.lostObjects!=null? lostService.objects.lostObjects.length:0,
                  itemBuilder: (BuildContext ctx, int i) {
                    if(lostService.objects.lostObjects[i].type =='perdido'){
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LostObjectDetail(object:lostService.objects.lostObjects[i])));

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(),
                              AspectRatio(
                                  aspectRatio: 4 / 4,
                                  child: lostService.objects.lostObjects[i].fullFiles.length>0 ? Image.network(
                                    lostService.objects.lostObjects[i].fullFiles[0],fit: BoxFit.cover,):Container())  ,
                              Text('${lostService.objects.lostObjects[i].name}',style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.w600),textAlign: TextAlign.start,),
                              Text('${lostService.objects.lostObjects[i].looseAtFormatDate}',style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.w400,fontSize: 10),textAlign: TextAlign.start,),

                            ],
                          ),
                        ),
                      );
                    }else{
                      return Container();
                    }
                  }),
            ),
          ),
        )
      ],
    );
  }
}
