// To parse this JSON data, do
//
//     final avatars = avatarsFromJson(jsonString);

import 'dart:convert';

Avatars avatarsFromJson(String str) => Avatars.fromJson(json.decode(str));

String avatarsToJson(Avatars data) => json.encode(data.toJson());

class Avatars {
  Avatars({
    this.avatars,
  });

  List<Avatar> avatars;

  factory Avatars.fromJson(Map<String, dynamic> json) => Avatars(
    avatars: List<Avatar>.from(json["avatars"].map((x) => Avatar.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "avatars": List<dynamic>.from(avatars.map((x) => x.toJson())),
  };
}

class Avatar {
  Avatar({
    this.name,
    this.fullFile,
  });

  String name;
  String fullFile;

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
    name: json["name"],
    fullFile: json["fullFile"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "fullFile": fullFile,
  };
}
