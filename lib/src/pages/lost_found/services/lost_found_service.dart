import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/addedobject_model.dart';
import 'package:litadesarrollos/src/models/files_model.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/lost_objects.dart';
import 'package:litadesarrollos/src/utils/globals.dart';
import 'package:http_parser/http_parser.dart';

class LostService with ChangeNotifier {
  static LoginResult _loginResult;

  void update(LoginResult lr) {
    _loginResult = lr;
    getObjects();
    notifyListeners();
  }

  static String query = r'''
 query($type: String) {
    lostObjects(type: $type) {
        _id
        postedBy {
            _id
            completeName
            fullFile
        }
        name
        description
        type
        looseAtFormatDate
        fullFiles
        updatedAtFormatDate
        isActive
    }
}
  ''';

  LoginResult get loginResult => _loginResult;

  static HttpLink httplink = HttpLink(
      uri: uri,
      headers: <String, String>{
        "Authorization": "${_loginResult.token}",
      });
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );
  LostList _objects = LostList();

  LostList get objects => _objects;
  LostList _found = LostList();

  LostList get found => _found;

  set isloading(bool isa) {
    _isloading = isa;
    notifyListeners();
  }

  Future<bool> getObjects() async {
    QueryOptions options = QueryOptions(
        documentNode: gql(query),
        variables: {"type": "perdido"},
        fetchPolicy: FetchPolicy.cacheAndNetwork);
    QueryOptions foptions = QueryOptions(
        documentNode: gql(query),
        variables: {"type": "encontrado"},
        fetchPolicy: FetchPolicy.cacheAndNetwork);
    isloading = true;
    QueryResult res = await _client.query(foptions);
    QueryResult res2 = await _client.query(options);
    _objects = lostListFromJson(jsonEncode(res2.data));
    _found = lostListFromJson(jsonEncode(res.data));
    isloading = false;

    notifyListeners();

    return true;
  }

  File _image;

  set image(File ni) {
    _image = ni;
    notifyListeners();
  }

  bool _isloading = false;

  File get image => _image;
  FilesUploaded _fileNames = FilesUploaded();

  FilesUploaded get fileNames => _fileNames;

  set fileNames(FilesUploaded fl) {
    _fileNames = fl;
    notifyListeners();
  }

  final _dio = new Dio();

  bool get isloading => _isloading;

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
        "$apiUrl/uploads?folder=lost-objects",
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
        print(_fileNames.fileNames);
        notifyListeners();
        print('se subio la foto');
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
    _isloading = false;

    notifyListeners();
  }

  DateTime _date = DateTime.now();

  DateTime get date => _date;

  set date(DateTime newDate) {
    _date = DateTime(newDate.year, newDate.month, newDate.day);

    notifyListeners();
  }

  AddedObj _objUploaded = AddedObj();

  AddedObj get objUploaded => _objUploaded;

  set objUploaded(AddedObj on) {
    _objUploaded = on;
    notifyListeners();
  }

  Future<bool> createlf(String type, String name, String description) async {
    String query = r'''
    mutation($name: String!, $description: String, $picture: [String], $type: LostObjectType!, $zone: String, $looseAt: String) {
    addLostObject(input: { name: $name, description: $description, picture: $picture, type: $type, zone: $zone, looseAt: $looseAt }) {
        _id
        name
        description
        picture
        fullFiles
        type
        zone
        looseAt
        looseAtFormatDate
        updatedAt
        createdAt
        isActive
    }
}
    ''';
    MutationOptions options =
        MutationOptions(documentNode: gql(query), variables: {
      "name": name,
      "description": description,
      "picture": "${_fileNames.fileNames[0]}",
      "type": type,
      "zone": "Zona- demo",
      "looseAt": date.toIso8601String()
    });
    QueryResult res = await _client.mutate(options);
    print(res.data);
    getObjects();
    if (res.hasException) {
      return false;
    }

    _fileNames.fileNames = null;
    _objUploaded = addedObjFromJson(jsonEncode(res.data));

    return true;
  }
}
