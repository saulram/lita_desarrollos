import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/directorio/services/directory_service.dart';
import 'package:litadesarrollos/src/pages/directorio/widgets/resident_directory_card.dart';
import 'package:litadesarrollos/src/pages/profile/profile_edit.dart';

import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:provider/provider.dart';

class ResidentTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final directory = Provider.of<DirectoryService>(context);
    if (directory.loading == true) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (directory.user.isPhoneActive) {
        return Scaffold(
          body: directory.residents.usersDirectory != null ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: directory.residents.usersDirectory.length,
            itemBuilder: (BuildContext ctx, int i) {
              return Padding(
                padding: const EdgeInsets.all(11.0),
                child: ResidentsCard(
                  completeName:
                      directory.residents.usersDirectory[i].completeName,
                  address:
                      directory.residents.usersDirectory[i].departmentId.name,
                  phone: directory.residents.usersDirectory[i].phone,
                  file: directory.residents.usersDirectory[i].fullFile,
                ),
              );
            },
          ): Center(child: CircularProgressIndicator(),),
        );
      } else {
        return Scaffold(
          body: Center(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * .1),
                  child: Text(
                    'Para tener acceso al directorio de Residentes, es necesario que autorices que tu número sea público en "editar perfil". Una vez que lo hayas autorizado, podrás acceder al directorio y los demás residentes de tu Condominio te podrán llamar y chatear contigo.',
                    style: GoogleFonts.sourceSansPro(),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (_)=> MyProfile()));
                  },
                  color: accentLita,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .2),
                    child: Text(
                      'Editar Perfil',
                      style: GoogleFonts.sourceSansPro(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            )),
          ),
        );
      }
    }
  }
}
