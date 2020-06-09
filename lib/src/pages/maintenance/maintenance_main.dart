import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/maintenance/tabs/complains_tab.dart';
import 'package:litadesarrollos/src/pages/maintenance/tabs/mto_tab.dart';
import 'package:litadesarrollos/src/pages/programedvisits/tabs/new_visit_tab.dart';
import 'package:litadesarrollos/src/pages/programedvisits/tabs/visits_regist_tab.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/bottom_lita.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';

class MaintenancePage extends StatefulWidget {
  @override
  _MaintenancePageState createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage>
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawerScrimColor: Colors.transparent,
        endDrawer: DrawerLita(),
        bottomNavigationBar: BottomLita(),
        appBar: AppBar(
          backgroundColor: HexColor('#FFFFFF'),
          title: Text(
            'Mantenimiento y Quejas',
            style: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w600, fontSize: 22),
          ),
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            controller: _controller,
            indicatorColor: HexColor('#333333'),
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: 'Mantenimiento',
              ),
              Tab(
                text: 'Queja de personal',
              ),

            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[

           MtoTab(),
            ComplainTab(),


          ],
        ),
      ),
    );
  }
}
