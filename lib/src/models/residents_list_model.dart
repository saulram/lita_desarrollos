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
    this.completeName,
    this.phone,
    this.departmentId,
  });

  String completeName;
  String phone;
  DepartmentId departmentId;

  factory UsersDirectory.fromJson(Map<String, dynamic> json) => UsersDirectory(
    completeName: json["completeName"],
    phone: json["phone"],
    departmentId: DepartmentId.fromJson(json["departmentId"]),
  );

  Map<String, dynamic> toJson() => {
    "completeName": completeName,
    "phone": phone,
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
