import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/polls_list_model.dart';
import 'package:litadesarrollos/src/models/vote_list_model.dart';

class PollService with ChangeNotifier {
  static String getPolls = r'''
  query {
    polls {
        _id
        question
        firstOption {
            answer
            votes
        }
        secondOption {
            answer
            votes
        }
        thirdOption {
            answer
            votes
        }
        percent {
            firstOption
            secondOption
            thirdOption
        }
        updatedAtFormat
        alreadyAnswer
    }
}
  ''';
  static String pollsMutation = r'''
 mutation($id: ID!, $option: Int!) {
    answer(id: $id, option: $option) {
        _id
        question
        firstOption {
            answer
            votes
        }
        secondOption {
            answer
            votes
        }
        thirdOption {
            answer
            votes
        }
        updatedAtFormat
    }
}
  ''';

  void update(LoginResult lr) {
    _loginResult = lr;
    getPollsFc();
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

  PollsList listOfPolls = PollsList();

  QueryOptions getPollsOptions = QueryOptions(
      documentNode: gql(getPolls),
      fetchPolicy: FetchPolicy.cacheAndNetwork);

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


  voteFunction(String id, int answer) async {
    MutationOptions voteMutationOptions = MutationOptions(
        documentNode: gql(pollsMutation),
        variables: {
          "id":"$id",
          "option":answer
        },

    );
    QueryResult res = await _client.mutate(voteMutationOptions);
    getPollsFc();

  }

 Future<void> getPollsFc() async {
   _loading = true;
   notifyListeners();
    QueryResult res = await _client.query(getPollsOptions);


    if (res.hasException) {
      print(res.exception);
    } else {
      listOfPolls = pollsListFromJson(jsonEncode(res.data));
      print(listOfPolls);
    }
    _loading = false;
    notifyListeners();
  }
}
