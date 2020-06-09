import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/personal_list_model.dart';
import 'package:litadesarrollos/src/pages/directorio/comments_page_personal.dart';
import 'package:litadesarrollos/src/pages/directorio/services/personal_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class PersonalProfile extends StatelessWidget {
  final PersonalDirectory personal;
  final String color;
  final User user;


   PersonalProfile({Key key, this.personal, this.color, this.user});



  final GlobalKey<FormBuilderState> comentKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final personalService = Provider.of<PersonalService>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          personal.completeName,
          style: GoogleFonts.sourceSansPro(
              fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: HexColor(color),
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * .02),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(personal.fullFile),
                        )),
                  ),
                ),
                radius: MediaQuery.of(context).size.width * .15,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .05, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Puesto',
                        style: GoogleFonts.sourceSansPro(
                            color: HexColor('#828282'), fontSize: 16),
                      ),
                    ),
                    Row(
                      children: [],
                    ),
                    Container(
                      child: Text(
                        '${personal.jobTitle}',
                        style: GoogleFonts.sourceSansPro(
                            color: HexColor('#333333'), fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 8),
                child: Row(
                  children: <Widget>[
                    ImageIcon(
                      AssetImage('assets/mobile.png'),
                      color: accentLita,
                    ),
                    Text(
                      '${personal.phone}',
                      style: GoogleFonts.sourceSansPro(
                          color: HexColor('#333333'), fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .22,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .05, left: 8),
                child: SingleChildScrollView(

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Descripcion',
                          style: GoogleFonts.sourceSansPro(
                              color: HexColor('#828282'), fontSize: 16),
                        ),
                      ),
                      Container(
                        child: Text(
                          '${personal.description}',
                          style: GoogleFonts.sourceSansPro(
                              color: HexColor('#333333'), fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .07,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.fullFile),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: FormBuilder(
                      key: comentKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: FormBuilderTextField(
                          attribute: "comment",
                          minLines: 1,
                          decoration: InputDecoration(
                            suffixIcon: personalService.isloading==true ? CircularProgressIndicator(): FlatButton(
                              onPressed: ()async  {
                                if(comentKey.currentState.saveAndValidate()){
                                  print(comentKey.currentState.value["comment"]);
                                  personalService.text = comentKey.currentState.value["comment"];
                                 bool completed = await personalService.addMensaje(personal.id);
                                 if(completed == true){
                                   print('Coment Agregado');
                                   comentKey.currentState.reset();
                                   personalService.getComments(personal.id);

                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalComments()));

                                 }else{
                                   print( 'Hubo un error');
                                 }
                                }
                              },
                              child: Text(
                                'Publicar',
                                style: GoogleFonts.sourceSansPro(
                                    color: HexColor(
                                        user.residency.theme.secondaryColor)),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                            labelText: "Escribe un comentario",
                            labelStyle: GoogleFonts.sourceSansPro(
                                color: HexColor(
                                    user.residency.theme.secondaryColor),
                                fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: HexColor(
                                      user.residency.theme.secondaryColor),
                                ),
                                borderRadius: BorderRadius.circular(18)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(),
              Row(
                children: <Widget>[
                  FlatButton(onPressed: () async{
                     personalService.getComments(personal.id);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalComments()));

                  },
                    child: Text('Ver todos los comentarios',style: GoogleFonts.sourceSansPro(color: HexColor(user.residency.theme.secondaryColor)),),)

                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
