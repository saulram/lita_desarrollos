import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/wall/pages/create_post_page.dart';
import 'package:litadesarrollos/src/pages/wall/services/wall_service.dart';
import 'package:litadesarrollos/src/pages/wall/widgets/post_widget.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/bottom_lita.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class WallMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginService>(context);
    final wallProvider = Provider.of<WallService>(context);

    return loginProvider.loginResult.user != null
        ? Scaffold(
            backgroundColor: Colors.white,
            endDrawer: DrawerLita(),
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Image.asset('assets/logocolor.png'),
            ),
            body: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AddComment()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(
                        MediaQuery.of(context).size.height * .02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              loginProvider.loginResult.user.fullFile),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              '¿Qué información quieres\n compartir a la comunidad?',
                              style: GoogleFonts.sourceSansPro(
                                  color: HexColor('#828282'), fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                wallProvider.isloading == true
                    ? // card skeleton
                    Expanded(
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int i) {
                              return Center(
                                child: CardSkeleton(
                                  style: SkeletonStyle(
                                    theme: SkeletonTheme.Light,
                                    isShowAvatar: true,
                                    isCircleAvatar: true,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16.0)),
                                    padding: EdgeInsets.all(32.0),
                                    barCount: 2,
                                    colors: [
                                      Colors.grey[300],
                                      Colors.grey[200],
                                      Colors.grey[100]
                                    ],
                                    backgroundColor: Color(0xffffff),
                                    isAnimation: true,

                                  ),
                                ),
                              );
                            }),
                      )
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: wallProvider.getWalls,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                              itemCount: wallProvider.listWalls.walls != null
                                  ? wallProvider.listWalls.walls.length
                                  : 0,
                              itemBuilder: (BuildContext ctx, int i) {
                                final FocusNode myFocusNode = FocusNode();

                                return PostWidget(
                                  wallsList: wallProvider.listWalls.walls[i],
                                  myFocusNode: myFocusNode,
                                  loginProvider: wallProvider.loginResult,
                                );
                              }),
                        ),
                      ),
              ],
            ),
            bottomNavigationBar: BottomLita(),
          )
        : Scaffold();
  }
}
