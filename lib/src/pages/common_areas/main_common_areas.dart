import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/common_areas/tabs/my_bookings.dart';
import 'package:litadesarrollos/src/pages/common_areas/tabs/space_tab.dart';
import 'package:litadesarrollos/src/pages/directorio/tabs/emergency_tab.dart';
import 'package:litadesarrollos/src/pages/directorio/tabs/general_tab.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

class CommonAreasPage extends StatefulWidget {
  @override
  _CommonAreasPageState createState() => _CommonAreasPageState();
}

class _CommonAreasPageState extends State<CommonAreasPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);

    return loginService.loginResult.user!= null ? DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawerScrimColor: Colors.transparent,
        endDrawer: DrawerLita(),

        appBar: AppBar(
          backgroundColor: primaryLita,
          title: Text(
            'Areas Comunes',
            style: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w600, fontSize: 22,color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            controller: _controller,
            indicatorColor: HexColor('#ffffff'),
            labelColor: Colors.white,
            isScrollable: true,

            tabs: <Widget>[
              Tab(
                text: 'Espacios',

              ),
              Tab(
                text: 'Mis reservas',
              ),

            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[

            SpaceTab(),
            MyBookingsTab(),

          ],
        ),
      ),
    ):Scaffold();
  }
}
