import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/vote_list_model.dart';

class VoteService with ChangeNotifier {
  static String getVotations = r'''
  query {
    votes {
        _id
        residencyId
        title
        description
        percent {
            upVote
            downVote
        }
        alreadyAnswer
    }
}
  ''';
  static String voteMutation = r'''
  mutation($id: ID!, $answer: Boolean!) {
    vote(id: $id, answer: $answer)
}
  ''';

  void update(LoginResult lr) {
    _loginResult = lr;
    getVotationsFc();
    notifyListeners();
  }

  static LoginResult _loginResult = LoginResult();

  LoginResult get loginResult => _loginResult;

  static HttpLink httplink = HttpLink(
      uri: 'https://lita-261516.appspot.com/graphql',
      headers: <String, String>{
        "Authorization": "${_loginResult.token}",
      });
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );

  QueryOptions getVotationsOptions = QueryOptions(
      documentNode: gql(getVotations),
      fetchPolicy: FetchPolicy.cacheAndNetwork);
  VoteList votations = VoteList();
  bool _loading = false;

  bool get loading => _loading;

  int _option = 0;

  int get option => _option;

  set option(int options) {
    _option = options;
    notifyListeners();
  }

  bool _trueAnswer = false;

  bool get trueAnswer => _trueAnswer;

  set trueAnswer(bool tansw) {
    _trueAnswer = tansw;
    notifyListeners();
  }

  bool _falseAnswer = false;

  bool get falseAnswer => _falseAnswer;

  set falseAnswer(bool tansw) {
    _falseAnswer = tansw;
    notifyListeners();
  }

  voteFunction(String id, bool answer) async {
    MutationOptions voteMutationOptions = MutationOptions(
      documentNode: gql(voteMutation),
      variables: {
        "id":"$id",
        "answer":answer
      }
    );
    QueryResult res = await _client.mutate(voteMutationOptions);
    getVotationsFc();

  }

  Future<void>getVotationsFc() async {
    _loading = true;
    notifyListeners();
    QueryResult res = await _client.query(getVotationsOptions);


    if (res.hasException) {

    } else {
      votations = voteListFromJson(jsonEncode(res.data));

    }
    _loading = false;
    notifyListeners();
  }
}
