import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageFullWall extends StatelessWidget {
  final String image;

  const ImageFullWall({Key key, this.image}) : super(key: key);


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
        child: Hero(
          tag: 'picture_wall$image',
          child: Center(
            child:  CachedNetworkImage(imageUrl: image,),
          ),
        ),
      ),
    );
  }
}
