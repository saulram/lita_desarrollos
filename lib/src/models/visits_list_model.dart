// To parse this JSON data, do
//
//     final visitsList = visitsListFromJson(jsonString);

import 'dart:convert';

VisitsList visitsListFromJson(String str) => VisitsList.fromJson(json.decode(str));

String visitsListToJson(VisitsList data) => json.encode(data.toJson());

class VisitsList {
  VisitsList({
    this.visits,
  });

  List<Visit> visits;

  factory VisitsList.fromJson(Map<String, dynamic> json) => VisitsList(
    visits: List<Visit>.from(json["visits"].map((x) => Visit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "visits": List<dynamic>.from(visits.map((x) => x.toJson())),
  };
}

class Visit {
  Visit({
    this.departmentId,
    this.visitorsName,
    this.type,
    this.typeFormat,
    this.vehicleModel,
    this.licensePlate,
    this.scheduleAtFormat,
    this.untilDateFormat,
    this.code,
    this.codeUrl,
    this.accessCode,
  });

  DepartmentId departmentId;
  String visitorsName;
  String type;
  String typeFormat;
  String vehicleModel;
  String licensePlate;
  String scheduleAtFormat;
  String untilDateFormat;
  String code;
  String codeUrl;
  dynamic accessCode;

  factory Visit.fromJson(Map<String, dynamic> json) => Visit(
    departmentId: DepartmentId.fromJson(json["departmentId"]),
    visitorsName: json["visitorsName"],
    type: json["type"],
    typeFormat: json["typeFormat"],
    vehicleModel: json["vehicleModel"],
    licensePlate: json["licensePlate"],
    scheduleAtFormat: json["scheduleAtFormat"],
    untilDateFormat: json["untilDateFormat"],
    code: json["code"],
    codeUrl: json["codeUrl"],
    accessCode: json["accessCode"],
  );

  Map<String, dynamic> toJson() => {
    "departmentId": departmentId.toJson(),
    "visitorsName": visitorsName,
    "type": type,
    "typeFormat": typeFormat,
    "vehicleModel": vehicleModel,
    "licensePlate": licensePlate,
    "scheduleAtFormat": scheduleAtFormat,
    "untilDateFormat": untilDateFormat,
    "code": code,
    "codeUrl": codeUrl,
    "accessCode": accessCode,
  };
}

class DepartmentId {
  DepartmentId({
    this.name,
  });

  String name;

  factory DepartmentId.fromJson(Map<String, dynamic> json) => DepartmentId(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
