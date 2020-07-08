import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/walls_model.dart';
import 'package:litadesarrollos/src/pages/wall/pages/watch_post_page.dart';
import 'package:litadesarrollos/src/pages/wall/services/wall_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:provider/provider.dart';

class WallPictureText extends StatelessWidget {
  final Wall wallsList;

  const WallPictureText({Key key, this.wallsList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final wallProvider = Provider.of<WallService>(context);
    return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(wallsList.postedById.fullFile),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${wallsList.postedById.completeName}',
                    style: GoogleFonts.sourceSansPro(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .78,
                    child: Text(
                      '${wallsList.description}',
                      style: GoogleFonts.sourceSansPro(),
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ),
                  Text(
                    '${wallsList.updateAtFormat}',
                    style: GoogleFonts.sourceSansPro(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height*.02,),
          wallsList.fullFiles.length > 0
              ? AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                wallsList.fullFiles[0],
                fit: BoxFit.cover,
              ))
              : Container(),
          SizedBox(height: MediaQuery.of(context).size.height*.01,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[ImageIcon(AssetImage('assets/comment.png')),
                  Text(
                    'Comentarios   ',
                    style: GoogleFonts.sourceSansPro(),
                  ),],
              ),
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
              )
            ],

          ),
          SizedBox(height: MediaQuery.of(context).size.height*.02,)
        ],
    );
  }
}
