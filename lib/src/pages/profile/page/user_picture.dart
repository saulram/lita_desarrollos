import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/pages/inicio/services/preference_service.dart';
import 'package:litadesarrollos/src/pages/profile/services/profile_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class UserProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileService = Provider.of<ProfileService>(context);
    final initialService = Provider.of<PrefService>(context);
    final loginService = Provider.of<LoginService>(context);

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
      profileService.image = image;
      profileService.uploadImage();
    };

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Selecciona una imagen',
            style: GoogleFonts.sourceSansPro(),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                var picture ;
                if(profileService.fileNames.fileNames!=null){
                  picture = profileService.fileNames.fileNames[0];
                }else{
                  picture = profileService.avatarName;
                }
                print(picture);
                LoginResult lr = await  initialService.updateScreenPreferences(isActive: profileService.user.user.isPhoneActive,file: picture,);
                if(lr.user != null){
                  int i = await Alert.alert(context, title:'Perfil actualizado');
                  if(i == 0 ){
                    loginService.loginUser();

                  }
                }

              },
              child: Text('Aplicar',style: GoogleFonts.sourceSansPro(color: accentLita),),
            )
          ],
        ),
        body: profileService.isloading == false
            ? SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: GridView.builder(
                          itemCount: profileService.list.avatars.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4, childAspectRatio: 1),
                          itemBuilder: (BuildContext ctx, int i) {
                            return InkWell(
                              onTap: () {
                                profileService.profilePic =
                                    profileService.list.avatars[i].fullFile;
                                profileService.avatarName = profileService.list.avatars[i].name;
                                profileService.image = null;
                                profileService.fileNames.fileNames = null;
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    profileService.list.avatars[i].fullFile),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Tu nueva imagen:\n',
                            style: GoogleFonts.sourceSansPro(fontSize: 16),
                          ),
                          Hero(
                            tag: 'profile',
                            child: CircleAvatar(
                              backgroundColor: HexColor(loginService
                                  .loginResult
                                  .user
                                  .residency
                                  .theme
                                  .secondaryColor),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * .02),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: profileService.image != null ? FileImage(profileService.image): NetworkImage(
                                            profileService.profilePic),
                                        fit: BoxFit.cover
                                      )),
                                ),
                              ),
                              radius: MediaQuery.of(context).size.width * .15,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CupertinoButton.filled(

                            onPressed: () {
                              getImage(ImgSource.Both);
                            },
                            child: Text(
                              'Tomar imagen',
                              style: GoogleFonts.sourceSansPro(),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
