import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/wall/services/wall_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:litadesarrollos/src/utils/hexcolor.dart';
import 'package:provider/provider.dart';

class AddCommentWidget extends StatefulWidget {
  final String postId;
  final FocusNode focusNode;


  const AddCommentWidget({Key key, this.postId, this.focusNode}) : super(key: key);

  @override
  _AddCommentWidgetState createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
   final  _addcommentKey = GlobalKey<FormState>(debugLabel: 'asd');

  // Define the controllers
  TextEditingController _titleController;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    // Remember that you have to dispose of the controllers once the widget is ready to be disposed of


    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wallProvider = Provider.of<WallService>(context);
    final loginProvider = Provider.of<LoginService>(context);
    print(widget.postId);
    return Form(
      key: _addcommentKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          focusNode: widget.focusNode,
          controller: _titleController,
          validator: (String value) {
            if (value.isEmpty) {
              return 'title is empty';
            } else {}
          },

          minLines: 1,
          decoration: InputDecoration(
            suffixIcon: wallProvider.isloading == true
                ? CircularProgressIndicator()
                : FlatButton(
                    onPressed: () async {
                    if(_addcommentKey.currentState.validate()){
                      if(wallProvider.commentId != null){
                        bool addReply = await wallProvider.createreplyComment(_titleController.text);
                        if(addReply == true){
                          wallProvider.commentId = null;
                        }

                      }else{
                        bool commented = await  wallProvider.createPostComment(widget.postId, _titleController.text);
                        if(commented == true){


                        }
                      }

                    }

                    },
                    child: Text(
                      'Publicar',
                      style: GoogleFonts.sourceSansPro(
                          color: HexColor(loginProvider.loginResult.user
                              .residency.theme.secondaryColor)),
                    ),
                  ),
            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            labelText: "Escribe un comentario",
            labelStyle: GoogleFonts.sourceSansPro(
                color: HexColor(loginProvider
                    .loginResult.user.residency.theme.secondaryColor),
                fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: HexColor(loginProvider
                      .loginResult.user.residency.theme.secondaryColor),
                ),
                borderRadius: BorderRadius.circular(18)),
          ),
        ),
      ),
    );
  }
}
