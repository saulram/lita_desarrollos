import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/walls_model.dart';
import 'package:litadesarrollos/src/pages/wall/pages/watch_post_page.dart';
import 'package:litadesarrollos/src/pages/wall/services/wall_service.dart';
import 'package:litadesarrollos/src/pages/wall/widgets/addcomment.dart';
import 'package:litadesarrollos/src/pages/wall/widgets/wall_comments.dart';
import 'package:litadesarrollos/src/pages/wall/widgets/wall_picture_text.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatelessWidget {
  final Wall wallsList;
  final FocusNode myFocusNode;
  final LoginResult loginProvider;

  const PostWidget(
      {Key key, this.wallsList, this.myFocusNode, this.loginProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wallProvider = Provider.of<WallService>(context);

    return Column(
      children: <Widget>[
       WallPictureText(wallsList: wallsList,),
        wallsList.comments.length > 0
            ? WallCommentsPost(wallsList: wallsList,loginProvider: loginProvider,myFocusNode: myFocusNode,)
            : Container(),
        Row(children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage(loginProvider.user.fullFile),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: AddCommentWidget(
              postId: wallsList.id,
              focusNode: myFocusNode,
            ),
          ),
        ]),
        FlatButton(
          onPressed: ()  {
             wallProvider.getComments(wallsList.id);

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WallComments(
                  postId: wallsList.id,


                    )));
          },
          child: Text(
            'Ver todos los comentarios',
            style: GoogleFonts.sourceSansPro(color: accentLita),
          ),
        ),
        Divider(),
      ],
    );
  }
}
