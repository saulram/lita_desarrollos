import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

import 'package:litadesarrollos/src/pages/maintenance/report_created_success.dart';
import 'package:litadesarrollos/src/pages/maintenance/services/mto_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MtoTab extends StatelessWidget {
  GlobalKey<FormBuilderState> addMto = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<LoginService>(context);
    final mtoService = Provider.of<MtoService>(context);
    Future getImage(ImgSource source) async {
      var image = await ImagePickerGC.pickImage(
        context: context,
        source: source,
        cameraIcon: Icon(
          CupertinoIcons.photo_camera_solid,
          color: Colors.red,
        ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
      );
      mtoService.image = image;
      mtoService.uploadImage();
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              userService.loginResult.user.fullFile),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        '${userService.loginResult.user.completeName}',
                        style: GoogleFonts.sourceSansPro(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    )
                  ],
                ),
                FormBuilder(
                  key: addMto,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: FormBuilderTextField(
                      attribute: "description",
                      textInputAction: TextInputAction.done,
                      decoration:
                          InputDecoration(labelText: "Escribe aquí tu reporte"),
                      validators: [FormBuilderValidators.required()],
                    ),
                  ),
                ),
                mtoService.image != null
                    ? Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(CupertinoIcons.clear),
                                onPressed: () {
                                  mtoService.fileNames = null;
                                  mtoService.image = null;
                                },
                              ),
                            ],
                          ),
                          mtoService.isloading == true
                              ? LinearProgressIndicator()
                              : Container(),
                          Image.file(
                            mtoService.image,
                            width: MediaQuery.of(context).size.width * .9,
                            height: MediaQuery.of(context).size.height * .15,
                            fit: BoxFit.cover,
                          )
                        ],
                      )
                    : Container(),
                GestureDetector(
                  onTap: () => getImage(ImgSource.Both),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                            width: 100,
                            child: ImageIcon(
                              AssetImage('assets/camera.png'),
                              color: HexColor(userService.loginResult.user
                                  .residency.theme.secondaryColor),
                            )),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .02),
                          child: Text(mtoService.image != null
                              ? 'Cambiar foto'
                              : 'Agregar fotos desde camara'),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*.15,),
                MaterialButton(

                  color: HexColor(userService
                      .loginResult.user.residency.theme.secondaryColor),
                  disabledColor: Colors.grey,
                  onPressed: mtoService.isloading ==true ? null: () async {
                    if(addMto.currentState.saveAndValidate()){
                    mtoService.description=  addMto.currentState.value["description"];
                      bool created = await mtoService.addComplainFuturo("maintenance");
                      if(created == true){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ReportDonePage(rn: mtoService.report.addComplain.reportId,)));
                        mtoService.fileNames = null;
                        mtoService.image = null;

                      }else{

                      }
                    }

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .2,
                        vertical: 10),
                    child: mtoService.isloading== false ? Text(
                      'Crear reporte',
                      style: GoogleFonts.sourceSansPro(color: Colors.white),
                    ): CircularProgressIndicator( strokeWidth: .5,backgroundColor: Colors.white,),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
