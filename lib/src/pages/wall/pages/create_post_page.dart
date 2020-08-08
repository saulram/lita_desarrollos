import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

import 'package:litadesarrollos/src/pages/maintenance/tabs/image_full.dart';
import 'package:litadesarrollos/src/pages/wall/services/wall_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddComment extends StatelessWidget {
  GlobalKey<FormBuilderState> addWall = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<LoginService>(context);
    final wallService = Provider.of<WallService>(context);
    Future getImage(ImgSource source) async {
      var image = await ImagePickerGC.pickImage(
          context: context,
          source: source,
          cameraIcon: Icon(
            CupertinoIcons.photo_camera,
          ), //
          cameraText: Text('Cámara'),
          galleryText: Text('Galeria'),// cameraIcon and gall
          galleryIcon: Icon(CupertinoIcons
              .video_camera) // eryIcon can change. If no icon provided default icon will be present
      );
      wallService.image = image;
      wallService.uploadImage();
    };

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Crear publicación',style: GoogleFonts.sourceSansPro(),),
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
          elevation: 0,


        ),
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
                  key: addWall,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: FormBuilderTextField(
                      attribute: "description",
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.sentences,
                      decoration:
                      InputDecoration(labelText: "Escribe aquí tu publicación"),
                      validators: [FormBuilderValidators.required()],
                    ),
                  ),
                ),
                wallService.image != null
                    ? Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(CupertinoIcons.clear),
                          onPressed: () {
                            wallService.fileNames = null;
                            wallService.image = null;
                          },
                        ),
                      ],
                    ),
                    wallService.isloading == true
                        ? LinearProgressIndicator()
                        : Container(),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageFull(image: wallService.image,)));
                      },
                      child: AspectRatio(
                        aspectRatio: 16/9,
                        child: Image.file(
                          wallService.image,
                          width: MediaQuery.of(context).size.width * .9,
                          height: MediaQuery.of(context).size.height * .15,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                          child: Text(wallService.image != null
                              ? 'Cambiar foto'
                              : 'Agregar fotos'),
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
                  onPressed: wallService.isloading ==true ? null: () async {
                    if(addWall.currentState.saveAndValidate()){
                      print('dassd');
                      wallService.description=  addWall.currentState.value["description"];
                      bool created = await wallService.addWall();
                      if(created == true){
                       Navigator.pop(context);
                        wallService.fileNames = null;
                        wallService.image = null;

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
                    child: wallService.isloading== false ? Text(
                      'Publicar',
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
