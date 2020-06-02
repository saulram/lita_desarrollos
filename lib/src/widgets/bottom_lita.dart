import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';

class BottomLita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      backgroundColor: Color.fromARGB(200, 242, 242, 242),
      items: [
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icono_inicio.png'),
              color: HexColor('#4E76B6'),
            ),
            title: Text(
              'Inicio',
              style: GoogleFonts.sourceSansPro(color: HexColor('#4E76B6')),
            )),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icono_social.png')),
            title: Text('Social')),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/icono_notificaciones.png')),
            title: Text('Notificaciones'))
      ],
    );
  }
}
