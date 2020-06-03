import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/directorio/services/directory_service.dart';
import 'package:litadesarrollos/src/pages/directorio/widgets/general_service_card.dart';
import 'package:litadesarrollos/src/pages/directorio/widgets/resident_directory_card.dart';

import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:provider/provider.dart';

class GeneralTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final directory = Provider.of<DirectoryService>(context);
    if (directory.loading == true) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: directory.residents.usersDirectory != null
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: directory.generalServices.directories.length,
                itemBuilder: (BuildContext ctx, int i) {
                  return Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: GeneralCard(
                      completeName:
                      directory.generalServices.directories[i].title,
                      phone: directory.generalServices.directories[i].phone,
                      description: directory.generalServices.directories[i].description,
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      );
    }
  }
}
