import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/walls_model.dart';

class PostCommentReply extends StatelessWidget {
  final List<ReplayId> replayIds;
  final LoginResult loginProvider;
  final Color color;

  const PostCommentReply({Key key, this.replayIds, this.loginProvider, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: replayIds.length > 1
          ? MediaQuery.of(context).size.height * .15
          : MediaQuery.of(context).size.height * .1,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: replayIds.length,
          itemBuilder: (BuildContext ctx, int k) {
            return Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .20,
                  right: MediaQuery.of(context).size.width * .05,
                  top: MediaQuery.of(context).size.height * .01),

              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(replayIds[k].postedById.fullFile),
                          radius: MediaQuery.of(context).size.width * .04,
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
                            replayIds[k].postedById.completeName,
                            style: GoogleFonts.sourceSansPro(
                                color: color!=null? color: Colors.black, fontSize: 16),
                          ),
                          Text(
                            replayIds[k].text,
                            style: GoogleFonts.sourceSansPro(
                                color: color!=null? color:Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
