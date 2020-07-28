import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/programedvisits/date_time_visit.dart';
import 'package:litadesarrollos/src/pages/programedvisits/services/visits_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class NewVisitTab extends StatelessWidget {
  final GlobalKey<FormBuilderState> _addvisit = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final visitProvider = Provider.of<VisitService>(context);

    if(visitProvider.user.user!=null){
      return Scaffold(
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _addvisit,
            initialValue: {},
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * .1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Programar nueva visita:',
                      style: GoogleFonts.sourceSansPro(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilderTextField(
                      textInputAction: TextInputAction.done,
                      attribute: "visitorsName",
                      decoration:
                      InputDecoration(labelText: "Nombre del visitante:"),
                      validators: [
                        FormBuilderValidators.required(
                            errorText: 'Este campo no puede quedar vacio')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormBuilderDropdown(
                      attribute: "type",

                      // initialValue: 'Male',
                      hint: Text('Tipo de visita'),
                      validators: [
                        FormBuilderValidators.required(
                            errorText: 'Este campo no puede quedar vacio')
                      ],
                      items: ['personal', 'provider', 'employee'].map((gender) {
                        switch (gender) {
                          case 'personal':
                            return DropdownMenuItem(
                                value: gender, child: Text("Personal"));
                          case 'provider':
                            return DropdownMenuItem(
                                value: gender, child: Text("Proveedor"));
                          case 'employee':
                            {
                              return DropdownMenuItem(
                                  value: gender, child: Text("Empleado"));
                            }
                          default:
                            return DropdownMenuItem(
                                value: gender, child: Text("$gender"));
                        }
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: FormBuilderTextField(
                      textInputAction: TextInputAction.done,
                      attribute: "vehicleModel",
                      decoration:
                      InputDecoration(labelText: "Modelo del vehículo"),
                      validators: [],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: FormBuilderTextField(
                      attribute: "licensePlate",
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(labelText: "Placas"),
                      validators: [],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          'Fecha y hora de visita',
                          style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.w600,
                            color: HexColor(visitProvider.user.user.residency.theme.secondaryColor),
                          ),
                        ),
                        onPressed: () {
                          if (_addvisit.currentState.saveAndValidate()) {
                            visitProvider.type =
                            _addvisit.currentState.value["type"];
                            visitProvider.vehicleModel =
                            _addvisit.currentState.value["vehicleModel"];
                            visitProvider.licensePlate =
                            _addvisit.currentState.value["licensePlate"];
                            visitProvider.visitorsName =
                            _addvisit.currentState.value["visitorsName"];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DateTimePageVisit(),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );

    }else{
      return Scaffold();

    }

  }
}
