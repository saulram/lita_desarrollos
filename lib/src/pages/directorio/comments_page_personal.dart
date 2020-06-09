import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/directorio/services/personal_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class PersonalComments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final personalService = Provider.of<PersonalService>(context);
    final userService = Provider.of<LoginService>(context);
    if (personalService.comments.comments != null) {
      return Scaffold(
          backgroundColor: HexColor(
              userService.loginResult.user.residency.theme.secondaryColor),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'Comentarios',
              style: GoogleFonts.sourceSansPro(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: HexColor(
                userService.loginResult.user.residency.theme.secondaryColor),
            elevation: 0,
          ),
          body: ListView.builder(
              itemCount: personalService.comments.comments.length,
              itemBuilder: (BuildContext ctx, int i) {
                return Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width*.03),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: HexColor(userService.loginResult.user.residency.theme.thirdColor),width: .2))
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(personalService
                                .comments.comments[i].postedById.fullFile),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: <Widget>[

                            Text(personalService.comments.comments[i]
                                .postedById.completeName,style: GoogleFonts.sourceSansPro(color: Colors.white,fontSize: 16),),
                            Text(
                                personalService.comments.comments[i].text,style: GoogleFonts.sourceSansPro(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w300),),
                            Text(
                              personalService.comments.comments[i].postedAtFormatDate,style: GoogleFonts.sourceSansPro(color: Colors.white,fontSize: 13,fontWeight: FontWeight.w300),),

                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }));
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
