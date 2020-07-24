import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/booking_model.dart';

class ReserveWidget extends StatelessWidget {
  final Booking book;


  const ReserveWidget({Key key, this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('${book.book.booking.commonAreaId.name}',style: GoogleFonts.sourceSansPro(color: Colors.white,fontSize: 22),textAlign: TextAlign.center,),
        Text('${book.book.booking.bookingDateFormat}',style: GoogleFonts.sourceSansPro(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,),
        Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                '${book.book.booking.commonAreaId.fullFiles[0]}')
            ,

            radius: MediaQuery.of(context).size.width*.4,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Recibirás una confirmación cuando tu reservación sea aceptada',style: GoogleFonts.sourceSansPro(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,),
        ),
        OutlineButton(
          borderSide: BorderSide(color: Colors.white),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Entendido',style: GoogleFonts.sourceSansPro(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,),
        ),
        Divider()
      ],
    );
  }
}
