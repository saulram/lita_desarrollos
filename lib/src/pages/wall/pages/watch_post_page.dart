import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/wall/services/wall_service.dart';
import 'package:litadesarrollos/src/pages/wall/widgets/add_comment_post_detail.dart';

import 'package:litadesarrollos/src/pages/wall/widgets/wall_comment_reply.dart';


import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:provider/provider.dart';

class WallComments extends StatelessWidget {
  final String postId;


   WallComments({Key key, this.postId}) : super(key: key);
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    final wallProvider = Provider.of<WallService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: accentLita,
        elevation: 0,
        title: Text(
          'Comentarios',
          style: GoogleFonts.sourceSansPro(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: accentLita,
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: Container(
                height: wallProvider.comments.length > 1
                    ? MediaQuery.of(context).size.height * .30
                    : MediaQuery.of(context).size.height * .15,
                child:wallProvider.isloading==true? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),): ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: wallProvider.comments.length,
                    itemBuilder: (BuildContext ctx, int j) {
                      final FocusNode myFocusNode = FocusNode();
                      //Comment Section.
                      return Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .03),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * .05,
                                  vertical: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          wallProvider
                                              .comments[j].postedById.fullFile,
                                        ),
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
                                          wallProvider.comments[j].postedById
                                              .completeName,
                                          style: GoogleFonts.sourceSansPro(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          wallProvider.comments[j].text,
                                          style: GoogleFonts.sourceSansPro(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.start,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              wallProvider.comments[j]
                                                  .postedAtFormatDate,
                                              style: GoogleFonts.sourceSansPro(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            FlatButton(
                                              onPressed: () {

                                                wallProvider.commentId =
                                                    wallProvider.comments[j].id;
                                                FocusScope.of(context)
                                                    .requestFocus(focusNode);
                                              },
                                              child: Text(
                                                'Responder',
                                                style:
                                                    GoogleFonts.sourceSansPro(
                                                        color: Colors.white,fontSize: 13),
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                wallProvider.commentId =
                                                    wallProvider.comments[j].id;
                                                FocusScope.of(context)
                                                    .requestFocus(myFocusNode);
                                              },
                                              child: Text(
                                                'Reportar',
                                                style:
                                                    GoogleFonts.sourceSansPro(
                                                        color: Colors.white,fontSize: 13),
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
                          wallProvider.comments[j].replayIds.length > 0
                              ? PostCommentReply(
                                  replayIds: wallProvider.comments[j].replayIds,
                                  loginProvider: wallProvider.loginResult,
                                  color: Colors.white,
                                )
                              : Container(),
                          Divider(
                            color: Colors.white,
                          ),
                        ],
                      );
                    }),
              )),
          Expanded(
            flex: 1,
            child: Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: Center(
                  child: CircleAvatar(
                    backgroundImage:
                    NetworkImage(wallProvider.loginResult.user.fullFile),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: AddCommentDetailPost(
                  postId: postId,
                  focusNode: focusNode,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
