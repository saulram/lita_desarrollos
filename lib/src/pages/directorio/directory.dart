import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/directorio/tabs/resident_tab.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:litadesarrollos/src/widgets/bottom_lita.dart';
import 'package:litadesarrollos/src/widgets/drawer_lita.dart';

class DirectoryPage extends StatefulWidget {
  @override
  _DirectoryPageState createState() => _DirectoryPageState();
}

class _DirectoryPageState extends State<DirectoryPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawerScrimColor: Colors.transparent,
        endDrawer: DrawerLita(),
        bottomNavigationBar: BottomLita(),
        appBar: AppBar(
          backgroundColor: HexColor('#FFFFFF'),
          title: Text(
            'Directorio',
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
                text: 'Telefonos de emergencia',
              ),
              Tab(
                text: 'Servicios Generales',
              ),
              Tab(
                text: 'Residentes',
              ),
              Tab(
                text: 'Personal',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            Container(
              color: Colors.red,
            ),
            Container(
              color: Colors.white,
            ),
            ResidentTab(),
            Container(
              color: Colors.amber,
            )
          ],
        ),
      ),
    );
  }
}
