import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/common_area_list_model.dart';
import 'package:litadesarrollos/src/pages/common_areas/services/common_area_service.dart';

import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class AreaComments extends StatelessWidget {
  final CommonArea area;
  final GlobalKey<FormBuilderState> commentsKey = GlobalKey<FormBuilderState>();

  AreaComments({Key key, this.area}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spaceService = Provider.of<CommonService>(context);
    final userService = Provider.of<LoginService>(context);
    if (spaceService.comments.comments != null &&
        spaceService.loading != true) {
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
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: ListView.builder(
                    itemCount: spaceService.comments != null
                        ? spaceService.comments.comments.length
                        : 0,
                    itemBuilder: (BuildContext ctx, int i) {
                      return Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * .03),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: HexColor(userService.loginResult.user
                                        .residency.theme.thirdColor),
                                    width: .2))),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(spaceService
                                      .comments
                                      .comments[i]
                                      .postedById
                                      .fullFile),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    spaceService.comments.comments[i].postedById
                                        .completeName,
                                    style: GoogleFonts.sourceSansPro(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    spaceService.comments.comments[i].text,
                                    style: GoogleFonts.sourceSansPro(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  Text(
                                    spaceService.comments.comments[i]
                                        .postedAtFormatDate,
                                    style: GoogleFonts.sourceSansPro(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              userService.loginResult.user.fullFile),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: FormBuilder(
                        key: commentsKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: FormBuilderTextField(
                            attribute: "comment",
                            minLines: 1,
                            style:
                                GoogleFonts.sourceSansPro(color: Colors.white),
                            decoration: InputDecoration(
                              suffixIcon: spaceService.loading == true
                                  ? Container(
                                      width: 10,
                                      height: 5,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: .5,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    )
                                  : FlatButton(
                                      onPressed: () async {
                                        if (commentsKey.currentState
                                            .saveAndValidate()) {
                                          print(commentsKey
                                              .currentState.value["comment"]);
                                          spaceService.text = commentsKey
                                              .currentState.value["comment"];

                                          bool completed = await spaceService
                                              .addMensaje(area.id);
                                          if (completed == true) {
                                            print('Coment Agregado');
                                            spaceService.getComments(area.id);
                                          } else {
                                            print('Hubo un error');
                                          }
                                        }
                                      },
                                      child: Text(
                                        'Publicar',
                                        style: GoogleFonts.sourceSansPro(
                                            color: Colors.white),
                                      ),
                                    ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 8),
                              labelText: "Escribe un comentario",
                              labelStyle: GoogleFonts.sourceSansPro(
                                  color: Colors.white, fontSize: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(18)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ));
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
