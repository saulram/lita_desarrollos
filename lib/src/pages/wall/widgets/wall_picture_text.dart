import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/walls_model.dart';
import 'package:litadesarrollos/src/pages/wall/pages/image_full.dart';
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
                    textAlign: TextAlign.start,
                    softWrap: true,

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
        SizedBox(
          height: MediaQuery.of(context).size.height * .02,
        ),
        wallsList.fullFiles.length > 0
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ImageFullWall(
                        image: wallsList.fullFiles[0],
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: 'picture_wall${wallsList.fullFiles[0]}',
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                        imageUrl:wallsList.fullFiles[0],
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
              )
            : Container(),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              onPressed: () {
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
        SizedBox(
          height: MediaQuery.of(context).size.height * .02,
        )
      ],
    );
  }
}
