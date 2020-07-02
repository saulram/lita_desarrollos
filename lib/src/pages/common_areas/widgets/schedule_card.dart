import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/common_areas/services/common_area_service.dart';
import 'package:provider/provider.dart';

class CardSchedule extends StatefulWidget {
  final String time;
  final VoidCallback action;

  const CardSchedule({Key key, this.time, this.action}) : super(key: key);

  @override
  _CardScheduleState createState() => _CardScheduleState();
}

class _CardScheduleState extends State<CardSchedule> {
  bool selected;

  @override
  void initState() {
    selected = false;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final spaceProvider = Provider.of<CommonService>(context);
    return Center(
      child: GestureDetector(
        onTap: () {
          if (spaceProvider.scheduleRank.length > 0) {
            print('Ya hay horario seleccionado.');
          } else {
            setState(() {
              selected = !selected;
            });
          }

          widget.action();
        },
        child: Container(
          width: MediaQuery.of(context).size.width * .6,
          height: MediaQuery.of(context).size.height * .07,
          margin: EdgeInsets.all(MediaQuery.of(context).size.height * .01),
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .01,
              horizontal: MediaQuery.of(context).size.width * .1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color:
                      selected == true && spaceProvider.scheduleRank.length > 0
                          ? Colors.grey
                          : Colors.white)),
          child: Center(
            child: Text(
              widget.time,
              style: GoogleFonts.sourceSansPro(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
