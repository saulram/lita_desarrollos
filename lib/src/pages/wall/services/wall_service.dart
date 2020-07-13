import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/files_model.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/walls_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:litadesarrollos/src/utils/globals.dart';

import 'package:flutter/cupertino.dart';



class WallService  with ChangeNotifier{
  static LoginResult _loginResult;
  void update(LoginResult lr){
    _loginResult= lr;
    getWalls();
    notifyListeners();

  }
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

  static String queryWall = r'''query {
    walls {
        _id
        postedById {
            _id
            completeName
            fullFile
        }
        fullFiles
        description
        updateAtFormat
        isActive
        comments {
            _id
            text
            postedAtFormatDate
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
        }
    }
}''';
  bool _isloading = false;
  bool get isloading =>_isloading;
  set isloading(bool isl){
    _isloading=isl;
    notifyListeners();
  }
  String _description = '';
  String get description=>_description;
  set description ( String nd){
    _description = nd;
    notifyListeners();
  }
  Future<bool> addWall () async {
    String query = r'''
    mutation($description: String, $pictures: [String]) {
    addWall(input: { description: $description, pictures: $pictures }) {
        _id
        postedById {
            _id
            completeName
            fullFile
        }
        description
        pictures
        fullFiles
        updateAtFormat
        isActive
    }
}
    ''';
    MutationOptions options;
    if(_fileNames.fileNames != null){
       options= MutationOptions(
          documentNode: gql(query),
          variables: {
            "description":"$_description",
            "pictures":"${_fileNames.fileNames[0]}"
          }
      );
    }else{
      options = MutationOptions(
          documentNode: gql(query),
          variables: {
            "description":"$_description",

          }
      );
    }

    isloading = true;
    QueryResult res = await _client.mutate(options);
    isloading = false;
    if(res.hasException){
      print(res.exception);
    }
    getWalls();
    return true;
  }

  QueryOptions getWallsOptions = QueryOptions(
      documentNode: gql(queryWall),
      fetchPolicy: FetchPolicy.cacheAndNetwork);
  WallsList _listwalls = WallsList();
  WallsList get listWalls => _listwalls;

  Future<bool> getWalls () async {
    isloading = true;
    QueryResult res = await _client.query(getWallsOptions);
    isloading=false;

    _listwalls = wallsListFromJson(jsonEncode(res.data));
    notifyListeners();
    return true;

  }

  File _image;

  set image(File ni) {
    _image = ni;
    notifyListeners();
  }

  File get image=>_image;
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
        "$apiUrl/uploads?folder=social",
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

  Future<bool> createPostComment(String wallId, String text)async{
    String query = r'''
    mutation($wallId: ID, $text: String!) {
    addComment(input: { text: $text, wallId: $wallId }) {
        _id
        bazaarId
        wallId
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
        "wallId":wallId,
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


    getWalls();
    return true;
  }
  String _commentId;
  set commentId(String cid){
    _commentId = cid;
    notifyListeners();
  }
  String get commentId => _commentId;

  Future<bool> createreplyComment( String text)async{
    String query = r'''
    mutation($text: String!, $commentId: ID) {
    addComment(input: { text: $text commentId: $commentId }) {
        _id
        bazaarId
        wallId
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
          "commentId":_commentId,
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


    getWalls();
    return true;
  }

  static String listAreaCommentsQuery = r'''
  query( $wallId: ID) {
    comments(params: {  wallId: $wallId,  }) {
        _id
       
        wallId
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

  Future<void> getComments(String pId) async {
    comments =  [];
    QueryOptions getComments = QueryOptions(
      documentNode: gql(listAreaCommentsQuery),
      variables: {"wallId": pId},
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

}