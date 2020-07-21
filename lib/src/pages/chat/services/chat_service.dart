import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/comment_list.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/pages/chat/models/chat_list_model.dart';
import 'package:litadesarrollos/src/utils/globals.dart';

class ChatService with ChangeNotifier {
  static LoginResult _loginResult;

  void update(LoginResult lr) {
    _loginResult = lr;
    getChats();
    notifyListeners();
  }

  static String query = r'''
query {
    chats {
        _id
        users {
            _id
            completeName
            fullFile
        }
        name
        isActive
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


bool _isloading = false;
bool get isloading =>_isloading;

  set isloading(bool isa) {
    _isloading = isa;
    notifyListeners();
  }
  ChatList _chatList ;
  ChatList get chatList =>_chatList;


  Future<bool> getChats() async {
    QueryOptions options = QueryOptions(
        documentNode: gql(query), fetchPolicy: FetchPolicy.cacheAndNetwork);

    isloading = true;
    QueryResult res = await _client.query(options);

    isloading = false;
    _chatList = chatListFromJson(jsonEncode(res.data));
    notifyListeners();

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


    getChats();
    return true;
  }
  String _commentId;
  set commentId(String cid){
    _commentId = cid;
    notifyListeners();
  }
  String get commentId => _commentId;
}
