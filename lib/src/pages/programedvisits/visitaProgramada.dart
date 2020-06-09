import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/programedvisits/tabs/new_visit_tab.dart';
import 'package:litadesarrollos/src/pages/programedvisits/tabs/visits_regist_tab.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/bottom_lita.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';

class VisitaProgramadaPage extends StatefulWidget {
  @override
  _VisitaProgramadaPageState createState() => _VisitaProgramadaPageState();
}

class _VisitaProgramadaPageState extends State<VisitaProgramadaPage>
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
            'Visitas Programadas',
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
                text: 'Nueva Visita',
              ),
              Tab(
                text: 'Registro de Visitas',
              ),

            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[

            NewVisitTab(),
            VisitsRegister(),


          ],
        ),
      ),
    );
  }
}
