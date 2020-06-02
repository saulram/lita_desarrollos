import 'package:flutter/material.dart';
import 'package:litadesarrollos/src/pages/directorio/widgets/resident_directory_card.dart';

class ResidentTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ResidentsCard(),
        ],
      ),
    );
  }
}
