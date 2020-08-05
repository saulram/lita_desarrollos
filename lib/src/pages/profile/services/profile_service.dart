import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/files_model.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/pages/profile/models/avatar_model.dart';

import 'package:litadesarrollos/src/utils/globals.dart';
import 'package:http_parser/http_parser.dart';

class ProfileService with ChangeNotifier {
  static LoginResult _loginResult = LoginResult();

  LoginResult get user => _loginResult;

  void update(LoginResult lr) {
    _loginResult = lr;

   _profilePic = lr.user.fullFile;

    getAvatars();
    notifyListeners();
  }
  String _profilePic;
  String get profilePic =>_profilePic;
  String _avatarName;
  String get avatarName=>_avatarName;
  set profilePic ( String pic){
    _profilePic = pic;

    notifyListeners();
  }
  set avatarName ( String name){
    _avatarName = name;

    notifyListeners();
  }

  File _image;

  set image(File ni) {
    _image = ni;
    notifyListeners();
  }

  bool _isloading = false;

  bool get isloading => _isloading;

  File get image => _image;

  FilesUploaded _fileNames = FilesUploaded();

  FilesUploaded get fileNames => _fileNames;

  set fileNames(FilesUploaded fl) {
    _fileNames = fl;
    notifyListeners();
  }

  final _dio = new Dio();

  void uploadImage() async {
    _isloading = true;
    notifyListeners();
    try {
      String filename = _image.path.split('/').last;
      FormData formData = new FormData.fromMap({
        "file": await MultipartFile.fromFile(_image.path,
            filename: filename, contentType: new MediaType('image', 'png')),
        "type": "image/png"
      });
      Response response = await _dio.post(
        "$apiUrl/uploads?folder=users",
        data: formData,
        options: Options(
          headers: {
            "accept": "*/*",
            "Authorization": "${_loginResult.token}",
            "Content-Type": "multipart/form-data"
          },
        ),
      );

      _isloading = false;
      if (response.statusCode == 200) {
        _fileNames = filesUploadedFromJson(jsonEncode(response.data));
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
    _isloading = false;

    notifyListeners();
  }

  static HttpLink httplink = HttpLink(uri: uri, headers: <String, String>{
    "Authorization": "${_loginResult.token}",
  });
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );

  Avatars _list = Avatars();

  Avatars get list => _list;

  set isloading(bool s) {
    _isloading = s;
    notifyListeners();
  }

  getAvatars() async {
    String query = r'''
   query {
    avatars {
        name
        fullFile
    }
}
   ''';
    QueryOptions options = QueryOptions(
      documentNode: gql(query),
    );
    isloading = true;
    QueryResult res = await _client.query(options);

    if (res.hasException) {
      print('Error al leer avatars');
    }
    _list = avatarsFromJson(jsonEncode(res.data));
    isloading = false;
    notifyListeners();
  }
}
