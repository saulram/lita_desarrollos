import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/common_areas/tabs/my_bookings.dart';
import 'package:litadesarrollos/src/pages/common_areas/tabs/space_tab.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/bottom_lita.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class CommonAreaAdmin extends StatefulWidget {
  @override
  _CommonAreaAdminState createState() => _CommonAreaAdminState();
}

class _CommonAreaAdminState extends State<CommonAreaAdmin>
     {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);

    return loginService.loginResult.user!= null ? Scaffold(
      backgroundColor: Colors.white,
      drawerScrimColor: Colors.transparent,
      endDrawer: DrawerLita(),

      appBar: AppBar(
        backgroundColor: primaryLita,
        title: Text(
          'Áreas Comunes',
          style: GoogleFonts.sourceSansPro(
              fontWeight: FontWeight.w600, fontSize: 22,color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,

      ),
      body:SpaceTab(),
      bottomNavigationBar: BottomLita(),
      ):Scaffold();

  }
}
