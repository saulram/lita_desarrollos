// To parse this JSON data, do
//
//     final addedObj = addedObjFromJson(jsonString);

import 'dart:convert';

AddedObj addedObjFromJson(String str) => AddedObj.fromJson(json.decode(str));

String addedObjToJson(AddedObj data) => json.encode(data.toJson());

class AddedObj {
  AddedObj({
    this.addLostObject,
  });

  AddLostObject addLostObject;

  factory AddedObj.fromJson(Map<String, dynamic> json) => AddedObj(
    addLostObject: AddLostObject.fromJson(json["addLostObject"]),
  );

  Map<String, dynamic> toJson() => {
    "addLostObject": addLostObject.toJson(),
  };
}

class AddLostObject {
  AddLostObject({
    this.id,
    this.name,
    this.description,
    this.picture,
    this.fullFiles,
    this.type,
    this.zone,
    this.looseAt,
    this.looseAtFormatDate,
    this.updatedAt,
    this.createdAt,
    this.isActive,
  });

  String id;
  String name;
  String description;
  List<String> picture;
  List<String> fullFiles;
  String type;
  String zone;
  String looseAt;
  String looseAtFormatDate;
  String updatedAt;
  String createdAt;
  bool isActive;

  factory AddLostObject.fromJson(Map<String, dynamic> json) => AddLostObject(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    picture: List<String>.from(json["picture"].map((x) => x)),
    fullFiles: List<String>.from(json["fullFiles"].map((x) => x)),
    type: json["type"],
    zone: json["zone"],
    looseAt: json["looseAt"],
    looseAtFormatDate: json["looseAtFormatDate"],
    updatedAt: json["updatedAt"],
    createdAt: json["createdAt"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "picture": List<dynamic>.from(picture.map((x) => x)),
    "fullFiles": List<dynamic>.from(fullFiles.map((x) => x)),
    "type": type,
    "zone": zone,
    "looseAt": looseAt,
    "looseAtFormatDate": looseAtFormatDate,
    "updatedAt": updatedAt,
    "createdAt": createdAt,
    "isActive": isActive,
  };
}
