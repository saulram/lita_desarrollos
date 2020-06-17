import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class BottomLita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginService = Provider.of<LoginService>(context);
    return BottomNavigationBar(
      backgroundColor: Color.fromARGB(200, 242, 242, 242),
      onTap: (int i) {
        loginService.pageView = i;
       var rt = ModalRoute.of(context).settings.name;
        if(rt != '/'){
          Navigator.popAndPushNamed(context,'/');
        }
      },
      currentIndex: loginService.pageView,
      selectedItemColor: HexColor('#4E76B6'),
      items: [
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icono_inicio.png'),
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
          title: Text('Notificaciones'),
        )
      ],
    );
  }
}
