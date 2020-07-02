// To parse this JSON data, do
//
//     final myBookingsList = myBookingsListFromJson(jsonString);

import 'dart:convert';

MyBookingsList myBookingsListFromJson(String str) => MyBookingsList.fromJson(json.decode(str));

String myBookingsListToJson(MyBookingsList data) => json.encode(data.toJson());

class MyBookingsList {
  MyBookingsList({
    this.myBookings,
  });

  List<MyBooking> myBookings;

  factory MyBookingsList.fromJson(Map<String, dynamic> json) => MyBookingsList(
    myBookings: List<MyBooking>.from(json["myBookings"].map((x) => MyBooking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "myBookings": List<dynamic>.from(myBookings.map((x) => x.toJson())),
  };
}

class MyBooking {
  MyBooking({
    this.id,
    this.residencyId,
    this.commonAreaId,
    this.userId,
    this.startAt,
    this.endAt,
    this.attendeesNumber,
    this.paymentStatus,
    this.isActive,
    this.updatedAtFormat,
    this.bookingDateFormat,
  });

  String id;
  String residencyId;
  CommonAreaId commonAreaId;
  UserId userId;
  String startAt;
  String endAt;
  int attendeesNumber;
  String paymentStatus;
  bool isActive;
  String updatedAtFormat;
  String bookingDateFormat;

  factory MyBooking.fromJson(Map<String, dynamic> json) => MyBooking(
    id: json["_id"],
    residencyId: json["residencyId"],
    commonAreaId: CommonAreaId.fromJson(json["commonAreaId"]),
    userId: UserId.fromJson(json["userId"]),
    startAt: json["startAt"],
    endAt: json["endAt"],
    attendeesNumber: json["attendeesNumber"],
    paymentStatus: json["paymentStatus"],
    isActive: json["isActive"],
    updatedAtFormat: json["updatedAtFormat"],
    bookingDateFormat: json["bookingDateFormat"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "residencyId": residencyId,
    "commonAreaId": commonAreaId.toJson(),
    "userId": userId.toJson(),
    "startAt": startAt,
    "endAt": endAt,
    "attendeesNumber": attendeesNumber,
    "paymentStatus": paymentStatus,
    "isActive": isActive,
    "updatedAtFormat": updatedAtFormat,
    "bookingDateFormat": bookingDateFormat,
  };
}

class CommonAreaId {
  CommonAreaId({
    this.id,
    this.name,
    this.fullFiles,
  });

  String id;
  String name;
  List<String> fullFiles;

  factory CommonAreaId.fromJson(Map<String, dynamic> json) => CommonAreaId(
    id: json["_id"],
    name: json["name"],
    fullFiles: List<String>.from(json["fullFiles"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "fullFiles": List<dynamic>.from(fullFiles.map((x) => x)),
  };
}

class UserId {
  UserId({
    this.id,
    this.completeName,
    this.fullFile,
  });

  String id;
  String completeName;
  String fullFile;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    completeName: json["completeName"],
    fullFile: json["fullFile"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "completeName": completeName,
    "fullFile": fullFile,
  };
}
