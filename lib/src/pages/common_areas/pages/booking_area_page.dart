import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/common_area_list_model.dart';
import 'package:litadesarrollos/src/pages/common_areas/pages/schedule_list.dart';
import 'package:litadesarrollos/src/pages/common_areas/services/common_area_service.dart';

import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class BookingArea extends StatelessWidget {
  final CommonArea area;

  const BookingArea({Key key, this.area}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LoginService>(context);
    final areasProvider = Provider.of<CommonService>(context);
    return Scaffold(
      backgroundColor: HexColor(
          userProvider.loginResult.user.residency.theme.secondaryColor),
      appBar: AppBar(
        backgroundColor: HexColor(userProvider.loginResult.user.residency.theme.secondaryColor),
        elevation: 0,
        title: Text(
          'Calendario de reservación',
          style: GoogleFonts.sourceSansPro(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
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
                            color: HexColor(userProvider
                                .loginResult.user.residency.theme.thirdColor),
                            width: .5))),
                child: CalendarCarousel<Event>(
                  onDayPressed: (DateTime date, List<Event> events) async {
                    areasProvider.date = date;
                    String date2 = date.year.toString() +
                        '-' +
                        date.month.toString() +
                        '-' +
                        date.day.toString();
                    bool isavailable =
                        await areasProvider.getSchedule(area.id, date2);
                    areasProvider.btn = isavailable;

                    if (isavailable==true) {
                      print('hay horarios');

                    } else {
                      Alert.alert(context,
                          title: 'No hay horarios disponibles');
                    }
                  },
                  locale: 'es_mx',
                  weekendTextStyle: GoogleFonts.sourceSansPro(
                    color: Colors.white,
                  ),
                  daysTextStyle: GoogleFonts.sourceSansPro(color: Colors.white),
                  selectedDayTextStyle: GoogleFonts.sourceSansPro(),
                  selectedDayButtonColor: HexColor(
                      userProvider.loginResult.user.residency.theme.mainColor),
                  todayButtonColor: Color.fromARGB(100, 255, 255, 255),
                  selectedDayBorderColor: Colors.transparent,
                  todayBorderColor: Colors.transparent,
                  showWeekDays: true,
                  selectedDateTime: areasProvider.date,

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
                  customDayBuilder: (
                    /// you can provide your own build function to make custom day containers
                    bool isSelectable,
                    int index,
                    bool isSelectedDay,
                    bool isToday,
                    bool isPrevMonthDay,
                    TextStyle textStyle,
                    bool isNextMonthDay,
                    bool isThisMonthDay,
                    DateTime day,
                  ) {
                    /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                    /// This way you can build custom containers for specific days only, leaving rest as default.

                    // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
                    return null;
                  },
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
                onPressed: areasProvider.btn != true ? null : ()  {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>SchedulePage() ));
                },
                disabledColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: HexColor(
                    userProvider.loginResult.user.residency.theme.mainColor),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .01,
                      horizontal: MediaQuery.of(context).size.width * .1),
                  child: areasProvider.loading
                      ? CircularProgressIndicator()
                      : Text(
                          'Seleccionar horario',
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
