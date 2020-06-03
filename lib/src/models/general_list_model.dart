// To parse this JSON data, do
//
//     final general = generalFromJson(jsonString);

import 'dart:convert';

General generalFromJson(String str) => General.fromJson(json.decode(str));

String generalToJson(General data) => json.encode(data.toJson());

class General {
  General({
    this.directories,
  });

  List<Directory> directories;

  factory General.fromJson(Map<String, dynamic> json) => General(
    directories: List<Directory>.from(json["directories"].map((x) => Directory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "directories": List<dynamic>.from(directories.map((x) => x.toJson())),
  };
}

class Directory {
  Directory({
    this.id,
    this.title,
    this.phone,
    this.category,
    this.description,
    this.isActive,
    this.updatedAtFormat,
  });

  String id;
  String title;
  String phone;
  String category;
  dynamic description;
  bool isActive;
  String updatedAtFormat;

  factory Directory.fromJson(Map<String, dynamic> json) => Directory(
    id: json["_id"],
    title: json["title"],
    phone: json["phone"],
    category: json["category"],
    description: json["description"],
    isActive: json["isActive"],
    updatedAtFormat: json["updatedAtFormat"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "phone": phone,
    "category": category,
    "description": description,
    "isActive": isActive,
    "updatedAtFormat": updatedAtFormat,
  };
}
