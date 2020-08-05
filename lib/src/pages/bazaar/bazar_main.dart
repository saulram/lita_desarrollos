import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/bazaar/services/bazaar_service.dart';
import 'package:litadesarrollos/src/pages/bazaar/pages/bazaar_detail.dart';
import 'package:litadesarrollos/src/pages/bazaar/pages/upload_article.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/bottom_lita.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class BazaarMain extends StatefulWidget {
  @override
  _BazaarMainState createState() => _BazaarMainState();
}

class _BazaarMainState extends State<BazaarMain>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);
    final bazarService = Provider.of<BazaarService>(context);

    return loginService.loginResult.user != null
        ? DefaultTabController(
            length: bazarService.categories.categoriesBazaar != null
                ? bazarService.categories.categoriesBazaar.length
                : 1,
            child: Scaffold(
              backgroundColor: Colors.white,
              drawerScrimColor: Colors.transparent,
              endDrawer: DrawerLita(),
              appBar: AppBar(
                backgroundColor: primaryLita,
                title: Text(
                  'Bazar',
                  style: GoogleFonts.sourceSansPro(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Colors.white),
                ),
                iconTheme: IconThemeData(color: Colors.white),
                elevation: 0,
                centerTitle: true,
                bottom: TabBar(
                  controller: _controller,
                  indicatorColor: HexColor('#ffffff'),
                  labelColor: Colors.white,
                  isScrollable: true,
                  tabs: bazarService.categories.categoriesBazaar == null
                      ? [
                          Tab(
                            text: 'Cargando...',
                            icon: Icon(CupertinoIcons.circle),
                          )
                        ]
                      : bazarService.categories.categoriesBazaar
                          .map<Widget>((categorie) {
                          return Tab(
                            text: categorie.name,
                          );
                        }).toList(),
                ),
              ),
              bottomNavigationBar: BottomLita(),
              body: TabBarView(
                  controller: _controller,
                  children: bazarService.categories.categoriesBazaar == null
                      ? [
                          ListSkeleton(
                            style: SkeletonStyle(
                              theme: SkeletonTheme.Light,
                              isShowAvatar: false,
                              barCount: 3,
                              colors: [
                                Colors.grey[300],
                                Colors.grey[400],
                                Colors.grey[100]
                              ],
                              isAnimation: true,
                            ),
                          )
                        ]
                      : bazarService.categories.categoriesBazaar
                          .map<Widget>((categorie) {
                          return Stack(
                            children: <Widget>[
                              Container(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .15,
                                  color: primaryLita,
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * .02),
                                  child:  loginService.loginResult.user.roles[0]!='resident' ? Container(): Column(
                                    children: <Widget>[

                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UploadBazarArticle(categories: bazarService.categories,)));
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.add_circle,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Subir un articulo',
                                                style:
                                                    GoogleFonts.sourceSansPro(
                                                        color: Colors.white),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * .11,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .6,
                                  width: MediaQuery.of(context).size.width,
                                  child: bazarService.isloading == true
                                      ? ListSkeleton(
                                          style: SkeletonStyle(
                                            theme: SkeletonTheme.Light,
                                            isShowAvatar: false,
                                            barCount: 3,
                                            colors: [
                                              Colors.grey[300],
                                              Colors.grey[400],
                                              Colors.grey[100]
                                            ],
                                            isAnimation: true,
                                          ),
                                        )
                                      : RefreshIndicator(
                                          onRefresh: bazarService.getBazaars,
                                          child: GridView.builder(
                                              shrinkWrap: true,
                                              cacheExtent:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      .2,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 10.0,
                                                      mainAxisSpacing: 20.0,
                                                      childAspectRatio: 3 / 4),
                                              itemCount:
                                                  categorie.bazaars != null
                                                      ? categorie.bazaars.length
                                                      : 0,
                                              itemBuilder:
                                                  (BuildContext ctx, int i) {
                                                return GestureDetector(
                                                  onTap: () {
                                                     Navigator.of(context).push(
                                      MaterialPageRoute(
                                      builder: (context) =>
                                      BazaarDetail(
                                      object: categorie.bazaars[i]))
                                      );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Row(),
                                                        AspectRatio(
                                                            aspectRatio: 4 / 4,
                                                            child:
                                                                Image.network(
                                                              categorie
                                                                  .bazaars[i]
                                                                  .fullFiles[0],
                                                              fit: BoxFit.cover,
                                                            )),
                                                        Text(
                                                          '${categorie.bazaars[i].name}',
                                                          style: GoogleFonts
                                                              .sourceSansPro(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                        Text(
                                                          r'$'+'${categorie.bazaars[i].price}.00 MXN',
                                                          style: GoogleFonts
                                                              .sourceSansPro(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 10),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                ),
                              )
                            ],
                          );
                        }).toList()),
            ),
          )
        : Scaffold();
  }
}
