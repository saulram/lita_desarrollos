// To parse this JSON data, do
//
//     final lostList = lostListFromJson(jsonString);

import 'dart:convert';

LostList lostListFromJson(String str) => LostList.fromJson(json.decode(str));

String lostListToJson(LostList data) => json.encode(data.toJson());

class LostList {
  LostList({
    this.lostObjects,
  });

  List<LostObject> lostObjects;

  factory LostList.fromJson(Map<String, dynamic> json) => LostList(
    lostObjects: List<LostObject>.from(json["lostObjects"].map((x) => LostObject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lostObjects": List<dynamic>.from(lostObjects.map((x) => x.toJson())),
  };
}

class LostObject {
  LostObject({
    this.id,
    this.postedBy,
    this.name,
    this.description,
    this.type,
    this.looseAtFormatDate,
    this.fullFiles,
    this.updatedAtFormatDate,
    this.isActive,
  });

  String id;
  PostedBy postedBy;
  String name;
  String description;
  String type;
  String looseAtFormatDate;
  List<String> fullFiles;
  String updatedAtFormatDate;
  bool isActive;

  factory LostObject.fromJson(Map<String, dynamic> json) => LostObject(
    id: json["_id"],
    postedBy: PostedBy.fromJson(json["postedBy"]),
    name: json["name"],
    description: json["description"],
    type: json["type"],
    looseAtFormatDate: json["looseAtFormatDate"],
    fullFiles: List<String>.from(json["fullFiles"].map((x) => x)),
    updatedAtFormatDate: json["updatedAtFormatDate"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "postedBy": postedBy.toJson(),
    "name": name,
    "description": description,
    "type": type,
    "looseAtFormatDate": looseAtFormatDate,
    "fullFiles": List<dynamic>.from(fullFiles.map((x) => x)),
    "updatedAtFormatDate": updatedAtFormatDate,
    "isActive": isActive,
  };
}

class PostedBy {
  PostedBy({
    this.id,
    this.completeName,
    this.fullFile,
  });

  String id;
  String completeName;
  String fullFile;

  factory PostedBy.fromJson(Map<String, dynamic> json) => PostedBy(
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
