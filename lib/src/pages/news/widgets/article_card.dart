import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/news_model_list.dart';
import 'package:litadesarrollos/src/theme/theme.dart';

// ignore: must_be_immutable
class NewsCard extends StatelessWidget {
  final News news;

  NewsCard({Key key, this.news}) : super(key: key);

  ExpandableController _controller = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: Image.network(news.fullFiles[0]),
      controller: _controller,
      collapsed: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(news.updatedAtFormat, style: GoogleFonts.sourceSansPro()),
              ],
            ),
            Text(
              news.title,
              style: GoogleFonts.sourceSansPro(
                  fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              news.description,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            FlatButton(
              onPressed: () {
                _controller.expanded = true;
              },
              padding: EdgeInsets.all(0),
              child: Text(
                'Mas información',
                style: GoogleFonts.sourceSansPro(color: accentLita),
              ),
            )
          ],
        ),
      ),
      expanded: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(news.updatedAtFormat, style: GoogleFonts.sourceSansPro()),
              ],
            ),
            Text(
              news.title,
              style: GoogleFonts.sourceSansPro(
                  fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              news.description,
              softWrap: true,

            ),
            FlatButton(
              onPressed: () {
                _controller.expanded = false;
              },
              padding: EdgeInsets.all(0),
              child: Text(
                'Menos información',
                style: GoogleFonts.sourceSansPro(color: accentLita),
              ),
            )
          ],
        ),
      ),
      // ignore: deprecated_member_use
      tapBodyToCollapse: true,
      // ignore: deprecated_member_use
      hasIcon: false,
    );
  }
}
