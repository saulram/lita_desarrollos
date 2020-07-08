import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:litadesarrollos/src/models/area_schedule_model.dart';
import 'package:litadesarrollos/src/models/booking_model.dart';
import 'package:litadesarrollos/src/models/comment_list.dart';
import 'package:litadesarrollos/src/models/common_area_list_model.dart';
import 'package:litadesarrollos/src/models/loginmodel.dart';
import 'package:litadesarrollos/src/models/my_books_moodel.dart';

class CommonService with ChangeNotifier {
  static LoginResult _user = LoginResult();
  CommonAreasList areasList = CommonAreasList();

  void update(LoginResult lr) {
    _user = lr;
    getCommonAreas();
    getMyReservations();
    notifyListeners();
  }

  static HttpLink httplink = HttpLink(
      uri: 'https://lita-261516.appspot.com/graphql',
      headers: <String, String>{
        "Authorization": "${_user.token}",
      });
  static GraphQLClient _client = GraphQLClient(
    cache: InMemoryCache(),
    link: httplink,
  );

  static String commonAreaQuery = r'''
  query {
    commonAreas {
        _id
        name
        picture
        fullFiles
        description
        schedule
        regulationTitle
        regulationContent
        regulationFile
        regulationFileUrl
        cost
        opensAt
        closesAt
        scheduleInterval
        createdAt
        updatedAt
        formatDate
    }
}
  ''';
  static String getbyIDquery = r'''
  query($id: ID!) {
    commonArea(id: $id) {
        _id
        name
        picture
        fullFiles
        description
        schedule
        regulationTitle
        regulationContent
        regulationFile
        regulationFileUrl
        cost
        createdAt
        updatedAt
        formatDate
        bookings {
            startAtFormat
            endAtFormat
            bookingDateFormat
        }
    }
}
  ''';

  static String listAreaCommentsQuery = r'''
  query($bazaarId: ID, $wallId: ID, $commonAreaId: ID, $personalId: ID) {
    comments(params: { bazaarId: $bazaarId, wallId: $wallId, commonAreaId: $commonAreaId, personalId: $personalId }) {
        _id
        bazaarId
        wallId
        text
        replayIds {
            _id
            text
            postedById {
                _id
                completeName
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

  CommentList comments = CommentList();

  Future<void> getComments(String pId) async {
    loading = true;
    QueryOptions getComments = QueryOptions(
      documentNode: gql(listAreaCommentsQuery),
      variables: {"commonAreaId": pId},
      fetchPolicy: FetchPolicy.cacheAndNetwork,
    );
    QueryResult res = await _client.query(getComments);
    loading = false;
    if (res.hasException) {
      print(res.exception);
    } else {
      comments = commentListFromJson(jsonEncode(res.data));
      print(res.data);

      notifyListeners();
    }
  }

  DateTime _date;

  DateTime get date => _date;

  set date(DateTime date) {
    _date = date;
    notifyListeners();
  }

  AreaSchedule _schedule = AreaSchedule();

  AreaSchedule get areaSchedule => _schedule;

  set areaSchedule(AreaSchedule sc) {
    _schedule = sc;
    notifyListeners();
  }

  bool _disablebtn = false;

  bool get btn => _disablebtn;

  set btn(bool b) {
    _disablebtn = b;
    notifyListeners();
  }

  String _scheduleRank = '';

  String get scheduleRank => _scheduleRank;

  set scheduleRank(String ns) {
    _scheduleRank = ns;
    notifyListeners();
  }

  String _areaID = '';

  Future<bool> getSchedule(String id, String date) async {
    String query = r'''
    query($id: ID!, $date: String!) {
    availability(filters: { id: $id, date: $date }) {
        schedule
        error
    }
}
    ''';
    _areaID = id;
    QueryOptions options = QueryOptions(
        documentNode: gql(query),
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        variables: {"id": id, "date": date});

    loading = true;
    QueryResult res = await _client.query(options);
    loading = false;
    if (res.hasException) {
      print(res.exception);
    }
    _schedule = areaScheduleFromJson(jsonEncode(res.data));

    return _schedule.availability.schedule.length == 0 ? false : true;
  }

  static String _text = '';

  String get text => _text;

  set text(String texto) {
    _text = texto;
    notifyListeners();
  }

  static String addAreaComment =
      r'''mutation($commonAreaId: ID, $text: String!) {
    addComment(input: { text: $text, commonAreaId: $commonAreaId }) {
        _id
        commonAreaId
        text
        postedAt
        postedAtFormatDate
        isActive
    }
}''';

  Future<bool> addMensaje(String idPersonal) async {
    //GETgeneral
    MutationOptions addMensaje = MutationOptions(
      documentNode: gql(addAreaComment),
      variables: {"commonAreaId": "$idPersonal", "text": _text},
    );
    _loading = true;
    notifyListeners();
    QueryResult res = await _client.mutate(addMensaje);
    if (res.hasException) {
      print(res.exception);
      _loading = false;
      notifyListeners();
      return false;
    } else {
      print(res.data);
      _loading = false;
      notifyListeners();
      return true;
    }
  }

  //Get CommonAreas
  QueryOptions commonOptions = QueryOptions(
      documentNode: gql(commonAreaQuery),
      fetchPolicy: FetchPolicy.cacheAndNetwork);
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool nl) {
    _loading = nl;
    notifyListeners();
  }

  Future<void> getCommonAreas() async {
    loading = true;
    QueryResult res = await _client.query(commonOptions);
    loading = false;

    if (res.hasException) {
      print(res.exception);
    } else {
      areasList = commonAreasListFromJson(jsonEncode(res.data));

      notifyListeners();
    }
  }
  Booking _booking = Booking();
  Booking get booking =>_booking;
  set booking(Booking bk){
    _booking = bk;
     notifyListeners();
  }
  Future<bool> bookDate() async {
    print(_scheduleRank);
    String month;
    if (date.month.toString().length == 1) {
      month = '0${date.month.toString()}';
    } else {
      month = date.month.toString();
    }
    String day;
    if (date.day.toString().length == 1) {
      day = '0${date.day.toString()}';
    } else {
      day = date.day.toString();
    }
    String date2 = date.year.toString() + '-' + month + '-' + day;
    print(date2);

    String options = r'''
    mutation($date: String!, $scheduleRank: String!, $commonAreaId: ID!, $attendeesNumber: Int) {
    book(input: { commonAreaId: $commonAreaId, date: $date, scheduleRank: $scheduleRank, attendeesNumber: $attendeesNumber }) {
        booking {
            _id
        commonAreaId {
            name
            fullFiles
        }
        userId {
            _id
            completeName
            fullFile
        }
        startAt
        endAt
        attendeesNumber
        paymentStatus
        isActive
        createdAt
        updatedAt
        updatedAtFormat
        bookingDateFormat
        }
        error
    }
}
    ''';
    MutationOptions bookOptions =
        MutationOptions(documentNode: gql(options), variables: {
      "date": date2,
      "scheduleRank": _scheduleRank,
      "commonAreaId": _areaID,
      "attendeesNumber": 3
    });
    loading = true;
    QueryResult res = await _client.mutate(bookOptions);
    loading = false;

    if (res.hasException) {
      print('Error:  ${res.exception}');
      return false;
    }
    print(res.data);
    booking = bookingFromJson(jsonEncode(res.data));
    return true;
  }
  MyBookingsList _myBooks = MyBookingsList();
  MyBookingsList get myBooks =>_myBooks;



  Future<bool> getMyReservations()async {
    _myBooks = MyBookingsList();
    String query = r'''query($lastId: ID) {
    myBookings(lastId: $lastId) {
        _id
        residencyId
        commonAreaId {
            _id
            name
            fullFiles
        }
        userId {
            _id
            completeName
            fullFile
        }
        startAt
        endAt
        attendeesNumber
        paymentStatus
        isActive
        updatedAtFormat
        bookingDateFormat
    }
}''';
    QueryOptions queryOptions = QueryOptions(
      documentNode: gql(query),
      fetchPolicy: FetchPolicy.cacheAndNetwork,

    );
    QueryResult res = await _client.query(queryOptions);
    if(res.hasException){
      print(res.exception);
    }
    print(res.data);
    _myBooks = myBookingsListFromJson(jsonEncode(res.data));
    notifyListeners();
    return true;


  }

  Future<bool> cancelBookings (String id) async {
    String query = r'''
    mutation($id: ID!) {
    cancelBook(id: $id)
}
    ''';
    MutationOptions options = MutationOptions (
      documentNode: gql(query),
      variables: {
        "id":id
      }
    );
    loading = true;
    QueryResult res = await _client.mutate(options);
    loading = false;
    if(res.hasException) {
      print(res.exception);
    return false;
    }
    else{
      print(res.data);
      getMyReservations();
      return true;
    }

  }




}
