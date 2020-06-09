import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/files_model.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/report_created_model.dart';
import 'package:litadesarrollos/src/pages/maintenance/services/queries.dart';

import 'package:litadesarrollos/src/utils/globals.dart';
import 'package:http_parser/http_parser.dart';

class MtoService with ChangeNotifier {
  static LoginResult _loginResult = LoginResult();

  LoginResult get user => _loginResult;

  void update(LoginResult lr) {
    _loginResult = lr;
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
        "$apiUrl/uploads?folder=complains",
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

    notifyListeners();
  }

  static HttpLink httplink = HttpLink(
      uri: 'https://lita-261516.appspot.com/graphql',
      headers: <String, String>{
        "Authorization": "${_loginResult.token}",
      });
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );
  String _description = '';

  String get description => _description;

  set description(String des) {
    _description = description;
    notifyListeners();
  }

  ReportCreated _report = ReportCreated();

  ReportCreated get report => _report;

  Future<bool> addComplainFuturo(String type) async {
    _isloading = true;
    notifyListeners();
    MutationOptions addComplainOptions = MutationOptions(
        documentNode: gql(addComplain),
        variables: {
          "description": " $_description",
          "type": "$type",
          "pictures": "$_fileNames"
        });
    QueryResult res = await _client.mutate(addComplainOptions);
    if (res.hasException) {
      print(res.exception);
      _isloading = false;
      notifyListeners();
      return false;
    } else {
      _isloading = false;
      notifyListeners();
      _report = reportCreatedFromJson(jsonEncode(res.data));
      print(res.data);

      return true;
    }
  }
}
