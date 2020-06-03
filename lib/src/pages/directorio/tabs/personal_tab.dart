import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/directorio/personal_profile.dart';
import 'package:litadesarrollos/src/pages/directorio/services/directory_service.dart';
import 'package:litadesarrollos/src/pages/directorio/widgets/personal_directory_card.dart';
import 'package:litadesarrollos/src/pages/directorio/widgets/resident_directory_card.dart';
import 'package:provider/provider.dart';

class PersonalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final directory = Provider.of<DirectoryService>(context);
    if (directory.loading == true) {
      return Center(
        child: CircularProgressIndicator(),
      );

    }else{
      if (directory.user.isPhoneActive) {
        return Scaffold(
          body: directory.residents.usersDirectory != null ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: directory.personald.personalDirectory.length,
            itemBuilder: (BuildContext ctx, int i) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>PersonalProfile(personal: directory.personald.personalDirectory[i],)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: PersonalCard(
                    completeName: directory.personald.personalDirectory[i].completeName,
                    address: directory.personald.personalDirectory[i].jobTitle,
                    phone: directory.personald.personalDirectory[i].phone,
                    horario: directory.personald.personalDirectory[i].personalSchedule,
                    description: directory.personald.personalDirectory[i].description,
                  ),
                ),
              );
            },
          ): Center(child: CircularProgressIndicator(),),
        );
      } else {
        return Scaffold(
          body: Center(
            child: Text('Acepta compartir tu telefono'),
          ),
        );
      }

    }

  }
}
