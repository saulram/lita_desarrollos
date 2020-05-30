
import 'package:graphql/client.dart';

String api_url = 'https://lita-261516.appspot.com/api';
String device = 'mobile';

final HttpLink _httpLink = HttpLink(
  
    uri: 'https://lita-261516.appspot.com/graphql',
);
HttpLink get httplink => _httpLink;