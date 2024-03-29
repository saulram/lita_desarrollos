import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/benefits/pages/benefit_detail.dart';
import 'package:litadesarrollos/src/pages/benefits/services/benefits_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/bottom_lita.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class BenefitsMain extends StatefulWidget {
  @override
  _BenefitsMainState createState() => _BenefitsMainState();
}

class _BenefitsMainState extends State<BenefitsMain>
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
    final benefitsService = Provider.of<BenefitsService>(context);

    return loginService.loginResult.user != null
        ? DefaultTabController(
      length: benefitsService.benefits.categoriesBenefits != null
          ? benefitsService.benefits.categoriesBenefits.length
          : 1,
      child: Scaffold(
        bottomNavigationBar: BottomLita(),
        backgroundColor: Colors.white,
        drawerScrimColor: Colors.transparent,
        endDrawer: DrawerLita(),
        appBar: AppBar(
          backgroundColor: primaryLita,
          title: Text(
            'Beneficios',
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
            tabs: benefitsService.benefits.categoriesBenefits == null
                ? [
              Tab(
                text: 'Cargando...',
                icon: Icon(CupertinoIcons.circle),
              )
            ]
                : benefitsService.benefits.categoriesBenefits
                .map<Widget>((categorie) {
              return Tab(
                text: categorie.name,
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
            controller: _controller,
            children: benefitsService.benefits.categoriesBenefits == null
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
                : benefitsService.benefits.categoriesBenefits
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
                      child: Column(
                        children: <Widget>[

                          InkWell(
                            onTap: () {

                            },
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .03,
                    child: Container(
                      height:
                      MediaQuery.of(context).size.height * .9,
                      width: MediaQuery.of(context).size.width,
                      child: benefitsService.isloading == true
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
                        onRefresh: benefitsService.getBenefits,
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
                            categorie.benefits != null
                                ? categorie.benefits.length
                                : 0,
                            itemBuilder:
                                (BuildContext ctx, int i) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BenefitDetail(
                                                  object: categorie.benefits[i]

                                                ))
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
                                                .benefits[i]
                                                .fullFile,
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        '${categorie.benefits[i].company}',
                                        style: GoogleFonts
                                            .sourceSansPro(

                                            fontWeight:
                                            FontWeight
                                                .w600),
                                        overflow:TextOverflow.ellipsis,
                                        maxLines:2,
                                        textAlign:
                                        TextAlign.start,
                                      ),
                                      Text(
                                        '${categorie.benefits[i].discount}',
                                        style: GoogleFonts
                                            .sourceSansPro(
                                            fontWeight:
                                            FontWeight
                                                .w400,
                                            fontSize: 10),
                                        overflow:TextOverflow.ellipsis,
                                        textAlign:
                                        TextAlign.start,
                                        maxLines:2
                                          ,

                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text('Sucursal: ',style: GoogleFonts.sourceSansPro(
                                            fontSize: 10,
                                            fontWeight:FontWeight.w600
                                          ),),
                                          Text(
                                            '${categorie.benefits[i].branch}',
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
