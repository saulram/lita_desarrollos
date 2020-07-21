
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:litadesarrollos/src/pages/bazaar/services/bazaar_service.dart';
import 'package:provider/provider.dart';

class AddCommentBazaarDetail extends StatefulWidget {
  final String bazarId;
  final FocusNode focusNode;


  const AddCommentBazaarDetail({Key key, this.bazarId, this.focusNode}) : super(key: key);

  @override
  _AddCommentDetailPostState createState() => _AddCommentDetailPostState();
}

class _AddCommentDetailPostState extends State<AddCommentBazaarDetail> {
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
    final wallProvider = Provider.of<BazaarService>(context);
    print(widget.bazarId);
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
            } else {
              return '';
            }
          },
          style: GoogleFonts.sourceSansPro(color: Colors.white),

          minLines: 1,
          decoration: InputDecoration(
            suffixIcon: wallProvider.isloading == true
                ? CircularProgressIndicator()
                : FlatButton(
              onPressed: () async {
                /**
                if(_addcommentKey.currentState.validate()){
                  if(wallProvider.commentId != null){
                    bool addReply = await wallProvider.createPostComment(_titleController.text);
                    if(addReply == true){
                      wallProvider.commentId = null;

                    }


                  }else{
                    bool commented = await  wallProvider.createPostComment(widget.postId, _titleController.text);
                    _titleController.clear();
                    if(commented == true){
                      wallProvider.getComments(widget.postId);



                    }

                  }


                }
                 **/

              },
              child: Text(
                'Publicar',
                style: GoogleFonts.sourceSansPro(
                    color: Colors.white),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            labelText: "Escribe un comentario",
            labelStyle: GoogleFonts.sourceSansPro(
                color: Colors.white,
                fontSize: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color:Colors.white)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color:Colors.white)
            ),
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
