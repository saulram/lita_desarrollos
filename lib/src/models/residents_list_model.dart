// To parse this JSON data, do
//
//     final residents = residentsFromJson(jsonString);

import 'dart:convert';

Residents residentsFromJson(String str) => Residents.fromJson(json.decode(str));

String residentsToJson(Residents data) => json.encode(data.toJson());

class Residents {
  Residents({
    this.usersDirectory,
  });

  List<UsersDirectory> usersDirectory;

  factory Residents.fromJson(Map<String, dynamic> json) => Residents(
    usersDirectory: List<UsersDirectory>.from(json["usersDirectory"].map((x) => UsersDirectory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "usersDirectory": List<dynamic>.from(usersDirectory.map((x) => x.toJson())),
  };
}

class UsersDirectory {
  UsersDirectory({
    this.id,
    this.completeName,
    this.phone,
    this.fullFile,
    this.departmentId,
  });

  String id;
  String completeName;
  String phone;
  String fullFile;
  DepartmentId departmentId;

  factory UsersDirectory.fromJson(Map<String, dynamic> json) => UsersDirectory(
    id: json["_id"],
    completeName: json["completeName"],
    phone: json["phone"],
    fullFile: json["fullFile"],
    departmentId: DepartmentId.fromJson(json["departmentId"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "completeName": completeName,
    "phone": phone,
    "fullFile": fullFile,
    "departmentId": departmentId.toJson(),
  };
}

class DepartmentId {
  DepartmentId({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory DepartmentId.fromJson(Map<String, dynamic> json) => DepartmentId(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
