import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/my_books_moodel.dart';
import 'package:litadesarrollos/src/pages/common_areas/services/common_area_service.dart';
import 'package:provider/provider.dart';

class MyBookCard extends StatelessWidget {
  final MyBooking book;


  const MyBookCard({Key key, this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final commonService = Provider.of<CommonService>(context);
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text('${book.commonAreaId.name}  \n',style: GoogleFonts.sourceSansPro(color: Colors.white,fontSize: 22),textAlign: TextAlign.center,),
        Text('${book.bookingDateFormat} \n',style: GoogleFonts.sourceSansPro(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,),
        Text('Estatus: \n ${book.paymentStatusFormat} \n',style: GoogleFonts.sourceSansPro(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,),
        Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                '${book.commonAreaId.fullFiles[0]}')
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
          onPressed: () async {
            int cancel = await Alert.confirm(context,title: 'Cancelar evento',content: '¿Estás seguro de querer cancelar?',ok: 'Si',cancel: 'No');
            if(cancel == 0){
              //cancel
              commonService.cancelBookings(book.id);

            }

          },
          child: Text('Cancelar',style: GoogleFonts.sourceSansPro(color: Colors.white,fontSize: 18),textAlign: TextAlign.center,),
        ),
        Divider( color: Colors.white,)
      ],
    );
  }
}
