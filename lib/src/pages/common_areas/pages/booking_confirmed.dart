import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/common_areas/services/common_area_service.dart';
import 'package:litadesarrollos/src/pages/common_areas/widgets/reserve_widget.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class BookingReceivedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final commonProvider = Provider.of<CommonService>(context);
    final userprovider = Provider.of<LoginService>(context);
    return Scaffold(
      backgroundColor:
          HexColor(userprovider.loginResult.user.residency.theme.mainColor),
      appBar: AppBar(
        backgroundColor:
            HexColor(userprovider.loginResult.user.residency.theme.mainColor),
        elevation: 0,
        title: Text(
          'Tu Solicitud ha sido recibida',
          style: GoogleFonts.sourceSansPro(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: ReserveWidget(
         book: commonProvider.booking
        )
      ),
    );
  }
}
