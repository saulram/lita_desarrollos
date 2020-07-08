import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/lost_found/services/lost_found_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class DateLost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lostProvider = Provider.of<LostService>(context);
    return Scaffold(
      backgroundColor: HexColor(
          lostProvider.loginResult.user.residency.theme.secondaryColor),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .04,
                    horizontal: MediaQuery.of(context).size.width * .05),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: HexColor(lostProvider
                                .loginResult.user.residency.theme.thirdColor),
                            width: .5))),
                child: CalendarCarousel<Event>(
                  onDayPressed: (DateTime date, List<Event> events) {
                    lostProvider.date = date;
                  },
                  locale: 'es_mx',
                  weekendTextStyle: GoogleFonts.sourceSansPro(
                    color: Colors.white,
                  ),
                  daysTextStyle: GoogleFonts.sourceSansPro(color: Colors.white),
                  selectedDayTextStyle: GoogleFonts.sourceSansPro(),
                  selectedDayButtonColor: HexColor(
                      lostProvider.loginResult.user.residency.theme.mainColor),
                  todayButtonColor: Color.fromARGB(100, 255, 255, 255),
                  selectedDayBorderColor: Colors.transparent,
                  todayBorderColor: Colors.transparent,
                  showWeekDays: true,
                  selectedDateTime: lostProvider.date,

                  weekdayTextStyle:
                      GoogleFonts.sourceSansPro(color: Colors.white),
                  headerTextStyle:
                      GoogleFonts.sourceSansPro(color: Colors.white),
                  headerTitleTouchable: false,
                  showHeaderButton: true,
                  leftButtonIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  rightButtonIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),

                  thisMonthDayBorderColor: Colors.transparent,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),

                  weekFormat: false,

                  height: 420.0,

                  daysHaveCircularBorder: true,

                  /// null for not rendering any border, true for circular border, false for rectangular border
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              MaterialButton(
                onPressed: () async {
                  print(lostProvider.date);

                 Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: HexColor(
                    lostProvider.loginResult.user.residency.theme.mainColor),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .01,
                      horizontal: MediaQuery.of(context).size.width * .1),
                  child: Text(
                          'Listo',
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white, fontSize: 17),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
