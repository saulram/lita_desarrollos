// To parse this JSON data, do
//
//     final booking = bookingFromJson(jsonString);

import 'dart:convert';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  Booking({
    this.book,
  });

  Book book;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    book: Book.fromJson(json["book"]),
  );

  Map<String, dynamic> toJson() => {
    "book": book.toJson(),
  };
}

class Book {
  Book({
    this.booking,
    this.error,
  });

  BookingClass booking;
  String error;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    booking: BookingClass.fromJson(json["booking"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "booking": booking.toJson(),
    "error": error,
  };
}

class BookingClass {
  BookingClass({
    this.id,
    this.commonAreaId,
    this.userId,
    this.startAt,
    this.endAt,
    this.attendeesNumber,
    this.paymentStatus,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.updatedAtFormat,
    this.bookingDateFormat,
  });

  String id;
  CommonAreaId commonAreaId;
  UserId userId;
  String startAt;
  String endAt;
  int attendeesNumber;
  String paymentStatus;
  bool isActive;
  String createdAt;
  String updatedAt;
  String updatedAtFormat;
  String bookingDateFormat;

  factory BookingClass.fromJson(Map<String, dynamic> json) => BookingClass(
    id: json["_id"],
    commonAreaId: CommonAreaId.fromJson(json["commonAreaId"]),
    userId: UserId.fromJson(json["userId"]),
    startAt: json["startAt"],
    endAt: json["endAt"],
    attendeesNumber: json["attendeesNumber"],
    paymentStatus: json["paymentStatus"],
    isActive: json["isActive"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    updatedAtFormat: json["updatedAtFormat"],
    bookingDateFormat: json["bookingDateFormat"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "commonAreaId": commonAreaId.toJson(),
    "userId": userId.toJson(),
    "startAt": startAt,
    "endAt": endAt,
    "attendeesNumber": attendeesNumber,
    "paymentStatus": paymentStatus,
    "isActive": isActive,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "updatedAtFormat": updatedAtFormat,
    "bookingDateFormat": bookingDateFormat,
  };
}

class CommonAreaId {
  CommonAreaId({
    this.name,
    this.fullFiles,
  });

  String name;
  List<String> fullFiles;

  factory CommonAreaId.fromJson(Map<String, dynamic> json) => CommonAreaId(
    name: json["name"],
    fullFiles: List<String>.from(json["fullFiles"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
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
