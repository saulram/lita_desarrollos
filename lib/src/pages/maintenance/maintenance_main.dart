import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/maintenance/tabs/complains_tab.dart';
import 'package:litadesarrollos/src/pages/maintenance/tabs/mto_tab.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/bottom_lita.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';
import 'package:provider/provider.dart';

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
    final loginService = Provider.of<LoginService>(context);
    return loginService.loginResult.user != null ? DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawerScrimColor: Colors.transparent,
        endDrawer: DrawerLita(),
        bottomNavigationBar: BottomLita(),
        appBar: AppBar(
          backgroundColor: HexColor('#FFFFFF'),
          title: Text(
            'Mantenimiento y quejas',
            style: GoogleFonts.sourceSansPro(
                fontWeight: FontWeight.w600, fontSize: 18),
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
    ): Scaffold();
  }
}
