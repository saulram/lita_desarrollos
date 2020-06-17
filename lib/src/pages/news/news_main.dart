import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/news/services/news_service.dart';
import 'package:litadesarrollos/src/pages/news/widgets/article_card.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginService>(context);
    final newsService = Provider.of<NewsService>(context);
    return loginProvider.loginResult.user != null
        ? Scaffold(
            endDrawer: DrawerLita(),
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: Colors.white),
              actionsIconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Avisos',
                style: GoogleFonts.sourceSansPro(color: Colors.white),
              ),
            ),
            body: Column(
              children: <Widget>[
                Container(
                  color: primaryLita,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Consulta aquí los avisos de la administración',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                newsService.isloading == false ? Expanded(
                  child: RefreshIndicator(
                    onRefresh: newsService.getNews,
                    child: ListView.builder(
                        itemCount: newsService.newsList.news.length ?? 1,
                        itemBuilder: (BuildContext ctx, int i) {
                          return Container(
                            child: NewsCard(news: newsService.newsList.news[i],),
                          );
                        }),
                  ),
                ) :CircularProgressIndicator()
              ],
            ),
          )
        : Scaffold();
  }
}
