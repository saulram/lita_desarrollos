import 'package:easy_alert/easy_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_expanded_tile/tileController.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:litadesarrollos/src/models/categories_bazar_model.dart';
import 'package:litadesarrollos/src/pages/bazaar/services/bazaar_service.dart';
import 'package:litadesarrollos/src/pages/lost_found/screens/lost_final.dart';
import 'package:litadesarrollos/src/theme/theme.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class UploadBazarArticle extends StatefulWidget {
  final CategoriesList categories;

  UploadBazarArticle({Key key, this.categories}) : super(key: key);
  List<bool> _selections = List.generate(2, (index) => false);

  @override
  _UploadBazarArticleState createState() => _UploadBazarArticleState();
}

class _UploadBazarArticleState extends State<UploadBazarArticle> {
  // Controller
  ExpandedTileController _controller;
  GlobalKey<FormBuilderState> _createBazar = GlobalKey<FormBuilderState>();

  void initState() {
    // initialize controller
    _controller = ExpandedTileController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bazarService = Provider.of<BazaarService>(context);
    Future getImage(ImgSource source) async {
      var image = await ImagePickerGC.pickImage(
        context: context,
        source: source,
        cameraIcon: Icon(
          CupertinoIcons.photo_camera_solid,
          color: Colors.red,
        ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
      );
      bazarService.image = image;
      bazarService.uploadImage();
    }

    Widget _buttons() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              bazarService.type = [
                !bazarService.type[0],
                !bazarService.type[1]
              ];
            },
            shape: StadiumBorder(side: BorderSide(color: Colors.white24)),
            color: bazarService.type[0] == true ? Colors.white60 : accentLita,
            child: Text(
              'Nuevo',
              style: GoogleFonts.sourceSansPro(
                color: bazarService.type[0] == true ? accentLita : Colors.white,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              bazarService.type = [
                !bazarService.type[0],
                !bazarService.type[1]
              ];
            },
            shape: StadiumBorder(side: BorderSide(color: Colors.white24)),
            color: bazarService.type[1] == true ? Colors.white60 : accentLita,
            child: Text(
              'Usado',
              style: GoogleFonts.sourceSansPro(
                color: bazarService.type[1] == true ? accentLita : Colors.white,
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: accentLita,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ExpandedTile(
                controller: _controller,
                checkable: false,
                headerPadding: EdgeInsets.symmetric(horizontal: 8),
                // check box enabled or not

                centerHeaderTitle: false,
                contentBackgroundColor: accentLita,
                rotateExpandIcon: true,
                expandIcon: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
                headerColor: accentLita,
                title: Text(
                  bazarService.category == null
                      ? 'Selecciona una categoria'
                      : bazarService.category,
                  style: GoogleFonts.sourceSansPro(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.start,
                ),
                content: Container(
                  height: MediaQuery.of(context).size.height * .18,
                  child: ListView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    children: widget.categories.categoriesBazaar
                        .map((e) => ListTile(
                              dense: true,
                              title: Text(
                                e.name,
                                style: GoogleFonts.sourceSansPro(
                                    color: Colors.white),
                              ),
                              onTap: () {
                                bazarService.category = e.name;
                                bazarService.cid = e.id;
                                _controller.collapse();
                              },
                            ))
                        .toList(),
                  ),
                )),
            FormBuilder(
              key: _createBazar,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                        maxLines: 1,
                        attribute: "title",
                        textInputAction: TextInputAction.done,
                        style: GoogleFonts.sourceSansPro(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: "Titulo",
                            labelStyle:
                                GoogleFonts.sourceSansPro(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                        validators: [FormBuilderValidators.required()],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                        maxLines: 3,
                        attribute: "description",
                        textInputAction: TextInputAction.done,
                        style: GoogleFonts.sourceSansPro(color: Colors.white),
                        maxLength: 250,
                        decoration: InputDecoration(
                            labelText: "Descripción",
                            labelStyle:
                                GoogleFonts.sourceSansPro(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                        validators: [FormBuilderValidators.required()],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                        maxLines: 1,
                        attribute: "price",
                        textInputAction: TextInputAction.done,
                        style: GoogleFonts.sourceSansPro(color: Colors.white),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              FontAwesomeIcons.dollarSign,
                              color: Colors.white,
                            ),
                            labelText: "Precio",
                            labelStyle:
                                GoogleFonts.sourceSansPro(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                        validators: [
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric()
                        ],
                      ),
                    ),
                    _buttons(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                    OutlineButton(
                      onPressed: () {
                        getImage(ImgSource.Both);
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
                      onPressed: bazarService.isloading == true ||
                              bazarService.fileNames.fileNames == null
                          ? null
                          : () async {
                              if (_createBazar.currentState.saveAndValidate()) {
                                if (bazarService.cid == null) {
                                  Alert.alert(
                                    context,
                                    title:
                                        'Aun no seleccionas la categoria',
                                  );
                                } else {
                                  bool lf = await bazarService.createBazaar(
                                      _createBazar.currentState.value['title'],
                                      _createBazar
                                          .currentState.value['description'],
                                      int.parse(_createBazar.currentState.value['price']));
                                  if (lf) {
                                    Navigator.of(context).pop();
                                  }

                                  //CREATE LOST / FOUND
                                }
                              }
                            },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: HexColor(bazarService
                          .loginResult.user.residency.theme.mainColor),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * .22),
                        child: bazarService.isloading == true
                            ? CircularProgressIndicator()
                            : Text(
                                'Publicar',
                                style: GoogleFonts.sourceSansPro(
                                    color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
