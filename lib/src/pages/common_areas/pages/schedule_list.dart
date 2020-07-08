import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/common_areas/pages/booking_confirmed.dart';
import 'package:litadesarrollos/src/pages/common_areas/services/common_area_service.dart';
import 'package:litadesarrollos/src/pages/common_areas/widgets/schedule_card.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final spaceProvider = Provider.of<CommonService>(context);
    final userProvider = Provider.of<LoginService>(context);
    print(spaceProvider.scheduleRank);
    return Scaffold(
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
      backgroundColor: HexColor(
          userProvider.loginResult.user.residency.theme.secondaryColor),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ListView.builder(
                  itemCount: spaceProvider.areaSchedule.availability != null
                      ? spaceProvider.areaSchedule.availability.schedule.length
                      : 0,
                  itemBuilder: (BuildContext ctx, int i) {
                    return CardSchedule(
                      time: spaceProvider.areaSchedule.availability.schedule[i],
                      action: () {
                        spaceProvider.scheduleRank =
                            spaceProvider.areaSchedule.availability.schedule[i];
                      },
                    );
                  }),
            ),
            spaceProvider.scheduleRank.length != 0
                ? Expanded(
                    child: Center(
                      child: IconButton(
                        icon: Icon(CupertinoIcons.clear_circled),
                        color: Colors.white,
                        onPressed: () {
                          spaceProvider.scheduleRank = '';
                        },
                      ),
                    ),
                  )
                : Container(),
            Expanded(
              flex: 1,
              child: Center(
                child: CupertinoButton(
                  onPressed: spaceProvider.scheduleRank.length >0  ? () async  {
                   bool booked = await spaceProvider.bookDate();
                   if(booked == true){
                     spaceProvider.scheduleRank = '';
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>BookingReceivedPage() ));
                   }else{
                     Alert.alert(context,title: 'No se logro crear reserva');
                   }
                  }:null,
                  color: primaryLita,
                  child: spaceProvider.loading == true? CircularProgressIndicator(): Text('Reservar'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
