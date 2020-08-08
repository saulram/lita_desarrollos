import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/bazaar/services/bazaar_service.dart';
import 'package:litadesarrollos/src/pages/wall/services/wall_service.dart';
import 'package:litadesarrollos/src/services/login_service.dart';
import 'package:provider/provider.dart';

class AddCommentDetailPost extends StatefulWidget {
  final String postId;
  final String bazaarId;
  final FocusNode focusNode;

  const AddCommentDetailPost(
      {Key key, this.postId, this.focusNode, this.bazaarId})
      : super(key: key);

  @override
  _AddCommentDetailPostState createState() => _AddCommentDetailPostState();
}

class _AddCommentDetailPostState extends State<AddCommentDetailPost> {
  final _addcommentKey = GlobalKey<FormState>(debugLabel: 'asd');

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
    final wallProvider = Provider.of<BazaarService>(context);
    final wallService = Provider.of<WallService>(context);
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
          style: GoogleFonts.sourceSansPro(color: Colors.white),
          minLines: 1,
          decoration: InputDecoration(
            suffixIcon: wallProvider.isloading == true
                ? CircularProgressIndicator()
                : FlatButton(
                    onPressed: () async {
                      if (_addcommentKey.currentState.validate()) {
                        if (wallService.commentId != null || wallProvider.commentId != null ) {
                          if(widget.postId != null ){
                            bool addReply = await wallService
                                .createreplyComment(_titleController.text);
                            if (addReply == true) {
                              wallService.commentId = null;
                              wallService.getComments(widget.postId);
                            }

                          }else{
                            bool addReply = await wallProvider
                                .createreplyComment(_titleController.text);
                            if (addReply == true) {
                              wallProvider.commentId = null;
                              wallProvider.getComments(widget.bazaarId);
                            }
                          }

                        } else {
                          bool commented = await wallProvider.createPostComment(
                              wallId: widget.postId,
                              text: _titleController.text,
                              bazaarId: widget.bazaarId);
                          _titleController.clear();
                          if (commented == true) {

                            if (widget.postId != null) {
                              wallService.getComments(widget.postId);
                            } else {
                              wallProvider.getComments(widget.bazaarId);
                            }
                          }
                        }
                      }
                    },
                    child: Text(
                      'Publicar',
                      style: GoogleFonts.sourceSansPro(color: Colors.white),
                    ),
                  ),
            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            labelText: "Escribe un comentario",
            labelStyle:
                GoogleFonts.sourceSansPro(color: Colors.white, fontSize: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: Colors.white)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(18)),
          ),
        ),
      ),
    );
  }
}
