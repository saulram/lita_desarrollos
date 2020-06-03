// To parse this JSON data, do
//
//     final personal = personalFromJson(jsonString);

import 'dart:convert';

Personal personalFromJson(String str) => Personal.fromJson(json.decode(str));

String personalToJson(Personal data) => json.encode(data.toJson());

class Personal {
  Personal({
    this.personalDirectory,
  });

  List<PersonalDirectory> personalDirectory;

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
    personalDirectory: List<PersonalDirectory>.from(json["personalDirectory"].map((x) => PersonalDirectory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "personalDirectory": List<dynamic>.from(personalDirectory.map((x) => x.toJson())),
  };
}

class PersonalDirectory {
  PersonalDirectory({
    this.id,
    this.completeName,
    this.phone,
    this.jobTitle,
    this.description,
    this.fullFile,
    this.personalSchedule,
  });

  String id;
  String completeName;
  String phone;
  String jobTitle;
  String description;
  String fullFile;
  String personalSchedule;

  factory PersonalDirectory.fromJson(Map<String, dynamic> json) => PersonalDirectory(
    id: json["_id"],
    completeName: json["completeName"],
    phone: json["phone"],
    jobTitle: json["jobTitle"],
    description: json["description"],
    fullFile: json["fullFile"],
    personalSchedule: json["personalSchedule"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "completeName": completeName,
    "phone": phone,
    "jobTitle": jobTitle,
    "description": description,
    "fullFile": fullFile,
    "personalSchedule": personalSchedule,
  };
}
