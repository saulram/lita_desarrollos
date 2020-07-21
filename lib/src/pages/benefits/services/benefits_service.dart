import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/pages/benefits/models/benefit_model.dart';
import 'package:litadesarrollos/src/pages/benefits/models/benefits_model.dart';

import 'package:litadesarrollos/src/utils/globals.dart';

class BenefitsService with ChangeNotifier {
  static LoginResult _loginResult;

  void update(LoginResult lr) {
    _loginResult = lr;
    getBenefits();
    notifyListeners();
  }

  static String query = r'''
query {
    categoriesBenefits {
        _id
        name
        
        benefits {
            _id
            title
            description
            picture
            fullFile
            discount
            company
            until
            phone
            website
            updatedAtFormat
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

  set isloading(bool isa) {
    _isloading = isa;
    notifyListeners();
  }
  BenefitsList _benefits = BenefitsList();

  BenefitsList get benefits =>_benefits;

  Future<bool> getBenefits() async {
    QueryOptions options = QueryOptions(
        documentNode: gql(query), fetchPolicy: FetchPolicy.cacheAndNetwork);

    isloading = true;
    QueryResult res = await _client.query(options);

    isloading = false;
    _benefits = benefitsListFromJson(jsonEncode(res.data));
    notifyListeners();

    return true;
  }


  bool _isloading = false;
  bool get isloading=>_isloading;


  Uint8List _currentCode;

  Uint8List get currentCode => _currentCode;
  ExchangeQrBenefit _newBenefit = ExchangeQrBenefit();
  ExchangeQrBenefit get newBenefit =>_newBenefit;

  Future<bool> getQr(String bId) async {
    ///Aqui enviamos el query para crear la fecha.
    ///
    String addExchangemutation = r'''
    mutation($benefitId: ID!) {
    addExchange(input: { benefitId: $benefitId }) {
        _id
        benefitId {
            title
            description
            discount
        }
        code
        codeUrl
        exchanged
        updatedAtFormat
        isActive
    }
}
    ''';






    MutationOptions addExchangeOptions =
    MutationOptions(documentNode: gql(addExchangemutation), variables: {
      "benefitId": '$bId',

    });
    _isloading = true;
    notifyListeners();
    QueryResult res = await _client.mutate(addExchangeOptions);
    if (res.hasException) {
      print(res.exception);
      _isloading = false;
      notifyListeners();
      return false;
    } else {
      _isloading = false;
      _newBenefit = exchangeQrBenefitFromJson(jsonEncode(res.data));
      print(_newBenefit);

      notifyListeners();
      getBenefits();
      return true;
    }
  }







}
