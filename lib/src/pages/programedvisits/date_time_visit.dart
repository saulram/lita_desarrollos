import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/programedvisits/visit_qr.dart';
import 'package:litadesarrollos/src/pages/programedvisits/services/visits_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class DateTimePageVisit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<LoginService>(context);
    final visitProvider= Provider.of<VisitService>(context);
    return Scaffold(
      backgroundColor: HexColor(
          userProvider.loginResult.user.residency.theme.secondaryColor),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.04,horizontal: MediaQuery.of(context).size.width*.05),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: HexColor(userProvider
                                .loginResult.user.residency.theme.thirdColor),width: .5))),
                child: CalendarCarousel<Event>(
                  onDayPressed: (DateTime date, List<Event> events) {
                   visitProvider.date = date;
                  },
                  locale: 'es_mx',
                  weekendTextStyle: GoogleFonts.sourceSansPro(
                    color: Colors.white,
                  ),
                  daysTextStyle: GoogleFonts.sourceSansPro(color: Colors.white),
                  selectedDayTextStyle: GoogleFonts.sourceSansPro(),
                  selectedDayButtonColor: HexColor(
                      userProvider.loginResult.user.residency.theme.mainColor),
                  todayButtonColor: HexColor(
                      userProvider.loginResult.user.residency.theme.mainColor),
                  selectedDayBorderColor: Colors.transparent,
                  todayBorderColor: Colors.transparent,
                  showWeekDays: true,
                  selectedDateTime: visitProvider.date,

                  weekdayTextStyle:
                      GoogleFonts.sourceSansPro(color: Colors.white),
                  headerTextStyle: GoogleFonts.sourceSansPro(color: Colors.white),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * .4,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: Text(
                          'Comienza',
                          style: GoogleFonts.sourceSansPro(color: Colors.white),
                        )),
                        TimePickerSpinner(
                          is24HourMode: false,
                          normalTextStyle: GoogleFonts.sourceSansPro(
                            fontSize: 16,
                            color: Colors.grey[500],
                          ),
                          highlightedTextStyle: GoogleFonts.sourceSansPro(
                              fontSize: 19, color: Colors.white),
                          spacing: MediaQuery.of(context).size.width * .00,
                          itemHeight: MediaQuery.of(context).size.height * .05,
                          isForce2Digits: true,
                          onTimeChange: (time) {
                           visitProvider.times = time;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .4,
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Termina',
                            style: GoogleFonts.sourceSansPro(color: Colors.white),
                          ),
                        ),
                        TimePickerSpinner(
                          is24HourMode: false,
                          normalTextStyle: GoogleFonts.sourceSansPro(
                              fontSize: 16, color: Colors.grey[500]),
                          highlightedTextStyle: GoogleFonts.sourceSansPro(
                              fontSize: 19, color: Colors.white),
                          spacing: MediaQuery.of(context).size.width * .01,
                          itemHeight: MediaQuery.of(context).size.height * .05,
                          isForce2Digits: true,
                          onTimeChange: (time) {
                            visitProvider.timeE = time;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              MaterialButton(
                onPressed: () async {
                 bool creado = await  visitProvider.getQr();
                 if(creado == true){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VisitQR(),),);
                 }else{
                   //TODO HANDLE ERROR
                 }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                color: HexColor(
                    userProvider.loginResult.user.residency.theme.mainColor),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .01,
                      horizontal: MediaQuery.of(context).size.width * .1),
                  child: visitProvider.isloading ? CircularProgressIndicator(): Text(
                    'Generar código',
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
