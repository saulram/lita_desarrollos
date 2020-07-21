import 'dart:convert';

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/addedobject_model.dart';
import 'package:litadesarrollos/src/models/categories_bazar_model.dart';
import 'package:litadesarrollos/src/models/comment_list.dart';
import 'package:litadesarrollos/src/models/files_model.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/lost_objects.dart';
import 'package:litadesarrollos/src/utils/globals.dart';
import 'package:http_parser/http_parser.dart';

class BazaarService with ChangeNotifier {
  static LoginResult _loginResult;

  void update(LoginResult lr) {
    _loginResult = lr;
    getBazaars();
    notifyListeners();
  }

  static String query = r'''
 query {
    categoriesBazaar {
        _id
        name
        bazaars {
            _id
            name
            description
            price
            fullFiles
            type
            formatDate
            isActive
            postedByUser {
                _id
                completeName
                fullFile
            }
        }
    }
}
  ''';

  LoginResult get loginResult => _loginResult;

  static HttpLink httplink = HttpLink(uri: uri, headers: <String, String>{
    "Authorization": "${_loginResult.token}",
  });
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );
  CategoriesList _categoriesBazaar = CategoriesList();

  CategoriesList get categories => _categoriesBazaar;
  String _category ;
  String get category =>_category;
  set category ( String ct){
    _category = ct;
    notifyListeners();
  }
  String _cid ;
  String get cid =>_category;
  set cid ( String ct){
    _cid = ct;
    notifyListeners();
  }
  List<bool> _type = [true,false];
  List<bool> get type => _type;
  set type (List<bool> bt){
    _type = bt;
    notifyListeners();
  }

  set isloading(bool isa) {
    _isloading = isa;
    notifyListeners();
  }

  Future<bool> getBazaars() async {
    QueryOptions options = QueryOptions(
        documentNode: gql(query), fetchPolicy: FetchPolicy.cacheAndNetwork);

    isloading = true;
    QueryResult res = await _client.query(options);

    isloading = false;
    _categoriesBazaar = categoriesListFromJson(jsonEncode(res.data));
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
        "$apiUrl/uploads?folder=bazaar",
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

  Future<bool> createBazaar( String name, String description,int price) async {
    String query = r'''
    mutation($bazaarCategoryId: ID!, $name: String!, $description: String, $picture: [String], $type: BazaarType, $price: Int) {
    addItem(input: { bazaarCategoryId: $bazaarCategoryId, name: $name, description: $description, picture: $picture, type: $type, price: $price }) {
        postedBy
        name
        type
        price
        picture
        fullFiles
        createdAt
        updatedAt
    }
}
    ''';
    String tipo = 'nuevo';
    if(type[0]==true){
      tipo = 'nuevo';
    }else{
      tipo= 'usado';
    }
    MutationOptions options =
        MutationOptions(documentNode: gql(query), variables: {
      "bazaarCategoryId": _cid,
       "name": name,
      "description": description,
      "picture": "${_fileNames.fileNames[0]}",
      "type": tipo,
      "price": price
    });
    QueryResult res = await _client.mutate(options);
    print(res.data);
    print(res.exception);
    getBazaars();
    if (res.hasException) {
      return false;
    }

    _fileNames.fileNames = null;
    cid = null;

    return true;
  }

  static String listAreaCommentsQuery = r'''
  query( $bazaarId: ID) {
    comments(params: {  bazaarId: $bazaarId,  }) {
        _id
       
        bazaarId
        text
        replayIds {
            _id
            text
            postedById {
                _id
                completeName
                fullFile
            }
            replayIds {
                _id
                text
                postedById {
                    _id
                    completeName
                    fullFile
                }
            }
        }
        postedById {
            _id
            completeName
            fullFile
        }
        complainById
        postedAt
        postedAtFormatDate
        isActive
    }
}
  ''';
  List<Comment> comments = [];

  Future<void> getComments(String bId) async {

    print(bId);
    QueryOptions getComments = QueryOptions(
      documentNode: gql(listAreaCommentsQuery),
      variables: {"bazaarId": bId},
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );
    QueryResult res = await _client.query(getComments);
    isloading = false;
    if (res.hasException) {
      print(res.exception);
    } else {

      comments = List<Comment>.from(res.data["comments"].map((x) => Comment.fromJson(x)));
      print(comments.toString());


      notifyListeners();
    }
  }


  Future<bool> createPostComment(String wallId, String text)async{
    String query = r'''
    mutation($bazaarId: ID, $text: String!) {
    addComment(input: { text: $text, bazaarId: $bazaarId }) {
        _id
        bazaarId
        text
        postedAt
        postedAtFormatDate
        isActive
    }
}
    ''';
    MutationOptions options = MutationOptions(
        documentNode: gql(query),
        variables: {
          "bazaarId":wallId,
          "text":text
        }
    );
    isloading = true;
    QueryResult res = await _client.mutate(options);
    isloading = false;
    print(res);
    if(res.hasException){
      return false;
    }


    getBazaars();
    return true;
  }
  String _commentId;
  set commentId(String cid){
    _commentId = cid;
    notifyListeners();
  }
  String get commentId => _commentId;
}
