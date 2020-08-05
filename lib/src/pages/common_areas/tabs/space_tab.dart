import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/common_areas/pages/booking_area_page.dart';
import 'package:litadesarrollos/src/pages/common_areas/pages/comments_common_page.dart';
import 'package:litadesarrollos/src/pages/common_areas/pages/common_rules.dart';
import 'package:litadesarrollos/src/pages/common_areas/services/common_area_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

final formatCurrency = new NumberFormat.simpleCurrency();
class SpaceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spaceService = Provider.of<CommonService>(context);

    return ListView.builder(
      itemBuilder: (BuildContext ctx, int i) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(spaceService.areasList.commonAreas[i].fullFiles[0]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                              spaceService.getComments(
                              spaceService.areasList.commonAreas[i].id
                            );
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AreaComments(area: spaceService.areasList.commonAreas[i],)));
                          },
                          child: Row(
                            children: <Widget>[
                              ImageIcon(AssetImage('assets/comment.png')),
                              Text(
                                'Comentarios',
                                style: GoogleFonts.sourceSansPro(),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "${spaceService.areasList.commonAreas[i].schedule}",
                          style: GoogleFonts.sourceSansPro(fontSize: 10,color: HexColor('#333333'),),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ),
                  Text(
                    '${spaceService.areasList.commonAreas[i].name}',
                    style: GoogleFonts.sourceSansPro(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${spaceService.areasList.commonAreas[i].description}',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.sourceSansPro(),
                  ),
                 spaceService.areasList.commonAreas[i].regulationContent == '' || spaceService.areasList.commonAreas[i].regulationFileUrl== null ? Container() : CupertinoButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RulesPage(area: spaceService.areasList.commonAreas[i],)));
                    },
                    padding: EdgeInsets.all(0),
                    child: Text(
                      'Reglamento',
                      style: GoogleFonts.sourceSansPro(
                          color: accentLita, fontSize: 16),
                    ),
                  ),
                  Text(
                      'Costo: ${formatCurrency.format(spaceService.areasList.commonAreas[i].cost)} MXN'),
                 spaceService.user.user.roles[0]!='resident'? Container(): Center(
                    child: CupertinoButton(
                      color: accentLita,

                        child: Text('Reservar'), onPressed: () {
                        print(spaceService.areasList.commonAreas[i].id
                        );
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BookingArea(area: spaceService.areasList.commonAreas[i],)));}),
                  )
                ],
              ),
            )
          ],
        );
      },
      itemCount: spaceService.areasList.commonAreas != null
          ? spaceService.areasList.commonAreas.length
          : 0,
    );
  }
}
