import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:litadesarrollos/src/pages/lost_found/screens/date_time_lost.dart';
import 'package:litadesarrollos/src/pages/lost_found/screens/found_final.dart';
import 'package:litadesarrollos/src/pages/lost_found/services/lost_found_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CreateFound extends StatelessWidget {
  GlobalKey<FormBuilderState> _foundkey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final lostService = Provider.of<LostService>(context);
    Future getImage(ImgSource source) async {
      var image = await ImagePickerGC.pickImage(
        context: context,
        source: source,
        cameraIcon: Icon(
          CupertinoIcons.photo_camera_solid,
          color: Colors.red,
        ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
      );
      lostService.image = image;
      lostService.uploadImage();
    }

    return Scaffold(
      backgroundColor:
      HexColor(lostService.loginResult.user.residency.theme.secondaryColor),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actionsIconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: Icon(CupertinoIcons.clear),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        backgroundColor: HexColor(
            lostService.loginResult.user.residency.theme.secondaryColor),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .07),
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => DateLost()));
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 9,
                        child: Text(
                          '¿Cuando se encontró?',
                          style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white),
                        )),
                    Expanded(
                      flex: 1,
                      child: Center(
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            FormBuilder(
              key: _foundkey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .1),
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      attribute: "title",
                      textInputAction: TextInputAction.done,
                      style: GoogleFonts.sourceSansPro(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: "Titulo",
                          labelStyle:
                          GoogleFonts.sourceSansPro(color: Colors.white),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      validators: [FormBuilderValidators.required()],
                    ),
                    FormBuilderTextField(
                      attribute: "description",
                      textInputAction: TextInputAction.done,
                      maxLength: 250,
                      style: GoogleFonts.sourceSansPro(color: Colors.white),
                      decoration: InputDecoration(
                          labelText: "Descripción",
                          labelStyle:
                          GoogleFonts.sourceSansPro(color: Colors.white),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      validators: [FormBuilderValidators.required()],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            OutlineButton(
              onPressed: () {
                getImage(ImgSource.Camera);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              borderSide: BorderSide(color: Colors.white),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .2),
                child: Text(
                  'Subir Foto',
                  style: GoogleFonts.sourceSansPro(color: Colors.white),
                ),
              ),
            ),
            MaterialButton(
              onPressed: lostService.isloading == true ||
                  lostService.fileNames.fileNames == null
                  ? null
                  : () async {
                if (_foundkey.currentState.saveAndValidate()) {
                  if (lostService.date == null) {
                    Alert.alert(
                      context,
                      title: 'Aun no seleccionas la fecha de perdida',
                    );
                  } else {
                    bool lf = await lostService.createlf(
                        "encontrado",
                        _foundkey.currentState.value["title"],
                        _foundkey.currentState.value["description"]);
                    if(lf){
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>FoundFinal()));
                    }

                    //CREATE LOST / FOUND
                  }
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: HexColor(
                  lostService.loginResult.user.residency.theme.mainColor),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .22),
                child: lostService.isloading == true
                    ? CircularProgressIndicator()
                    : Text(
                  'Publicar',
                  style: GoogleFonts.sourceSansPro(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
