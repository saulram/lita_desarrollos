import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';

class ResidentsCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: CircleAvatar(
              backgroundColor: Colors.red,
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Juan Carlos',
                  style: GoogleFonts.sourceSansPro(
                      fontSize: 18, color: HexColor('#333333')),
                ),
                Text('Departamento 12 Torre B')
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap:(){},
                  child: Column(
                    children: <Widget>[
                      ImageIcon(AssetImage('assets/mobile.png'),color: accentLita,),
                      Text('Llamar',style: GoogleFonts.sourceSansPro(fontSize: 10),)
                    ],
                  ),
                ),
                GestureDetector(
                  onTap:(){},
                  child: Column(
                    children: <Widget>[
                      ImageIcon(AssetImage('assets/msgbu.png'),color: accentLita,),
                      Text('Mensaje',style: GoogleFonts.sourceSansPro(fontSize: 10),)
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
