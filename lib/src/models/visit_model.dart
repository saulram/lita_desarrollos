// To parse this JSON data, do
//
//     final visitAdded = visitAddedFromJson(jsonString);

import 'dart:convert';

VisitAdded visitAddedFromJson(String str) => VisitAdded.fromJson(json.decode(str));

String visitAddedToJson(VisitAdded data) => json.encode(data.toJson());

class VisitAdded {
  VisitAdded({
    this.addVisit,
  });

  AddVisit addVisit;

  factory VisitAdded.fromJson(Map<String, dynamic> json) => VisitAdded(
    addVisit: AddVisit.fromJson(json["addVisit"]),
  );

  Map<String, dynamic> toJson() => {
    "addVisit": addVisit.toJson(),
  };
}

class AddVisit {
  AddVisit({
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

  factory AddVisit.fromJson(Map<String, dynamic> json) => AddVisit(
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
