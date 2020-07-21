import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/walls_model.dart';
import 'package:litadesarrollos/src/pages/wall/services/wall_service.dart';
import 'package:litadesarrollos/src/pages/wall/widgets/wall_comment_reply.dart';
import 'package:provider/provider.dart';

class WallCommentsPost extends StatelessWidget {
  final Wall wallsList;
  final LoginResult loginProvider;
  final FocusNode myFocusNode;
  final Color color;

  const WallCommentsPost({Key key, this.wallsList, this.loginProvider, this.myFocusNode, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final wallProvider = Provider.of<WallService>(context);


    return Container(
      height: wallsList.comments.length>1 ?MediaQuery.of(context).size.height * .30 : MediaQuery.of(context).size.height*.15,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
          itemCount: wallsList.comments.length,
          itemBuilder: (BuildContext ctx, int j) {
            //Comment Section.
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                      MediaQuery.of(context).size.width * .015),

                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal:
                        MediaQuery.of(context).size.width * .02,
                        vertical: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start
                      ,
                      children: <Widget>[
                        Expanded(
                          child: Center(
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  wallsList
                                      .comments[j]
                                      .postedById
                                      .fullFile),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                wallsList
                                    .comments[j]
                                    .postedById
                                    .completeName,
                                style: GoogleFonts.sourceSansPro(
                                    color: color!= null? color : Colors.black,
                                    fontSize: 16),
                              ),
                              Text(
                                wallsList
                                    .comments[j].text,
                                style: GoogleFonts.sourceSansPro(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.start,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    wallsList
                                        .comments[j]
                                        .postedAtFormatDate,
                                    style: GoogleFonts.sourceSansPro(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      print(wallsList.comments[j].id);
                                      wallProvider.commentId =
                                          wallsList
                                              .comments[j]
                                              .id;
                                      FocusScope.of(context)
                                          .requestFocus(myFocusNode);
                                    },
                                    child: Text(
                                      'Responder',
                                      style:
                                      GoogleFonts.sourceSansPro(),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Alert.alert(context,title: 'Se ha reportado al administrador');
                                    },
                                    child: Text(
                                      'Reportar',
                                      style:
                                      GoogleFonts.sourceSansPro(),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                wallsList.comments[j].replayIds
                    .length >
                    0
                    ? PostCommentReply(replayIds: wallsList.comments[j].replayIds,loginProvider: loginProvider,)
                    : Container(),
              ],
            );
          }),
    );
  }
}
