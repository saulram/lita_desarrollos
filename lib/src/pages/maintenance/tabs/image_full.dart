import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageFull extends StatelessWidget {
 final File image;

  const ImageFull({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(100, 0, 0, 0 ),
        elevation: 0,

      ),
      body: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: Center(
          child: Image.file(
            image,

            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
