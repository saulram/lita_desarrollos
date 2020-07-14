// To parse this JSON data, do
//
//     final categoriesList = categoriesListFromJson(jsonString);

import 'dart:convert';

CategoriesList categoriesListFromJson(String str) => CategoriesList.fromJson(json.decode(str));

String categoriesListToJson(CategoriesList data) => json.encode(data.toJson());

class CategoriesList {
  CategoriesList({
    this.categoriesBazaar,
  });

  List<CategoriesBazaar> categoriesBazaar;

  factory CategoriesList.fromJson(Map<String, dynamic> json) => CategoriesList(
    categoriesBazaar: List<CategoriesBazaar>.from(json["categoriesBazaar"].map((x) => CategoriesBazaar.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categoriesBazaar": List<dynamic>.from(categoriesBazaar.map((x) => x.toJson())),
  };
}

class CategoriesBazaar {
  CategoriesBazaar({
    this.id,
    this.name,
    this.bazaars,
  });

  String id;
  String name;
  List<Bazaar> bazaars;

  factory CategoriesBazaar.fromJson(Map<String, dynamic> json) => CategoriesBazaar(
    id: json["_id"],
    name: json["name"],
    bazaars: List<Bazaar>.from(json["bazaars"].map((x) => Bazaar.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "bazaars": List<dynamic>.from(bazaars.map((x) => x.toJson())),
  };
}

class Bazaar {
  Bazaar({
    this.id,
    this.name,
    this.description,
    this.price,
    this.fullFiles,
    this.type,
    this.formatDate,
    this.isActive,
    this.postedByUser,
  });

  String id;
  String name;
  String description;
  int price;
  List<String> fullFiles;
  String type;
  String formatDate;
  bool isActive;
  PostedByUser postedByUser;

  factory Bazaar.fromJson(Map<String, dynamic> json) => Bazaar(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    fullFiles: List<String>.from(json["fullFiles"].map((x) => x)),
    type: json["type"],
    formatDate: json["formatDate"],
    isActive: json["isActive"],
    postedByUser: PostedByUser.fromJson(json["postedByUser"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "price": price,
    "fullFiles": List<dynamic>.from(fullFiles.map((x) => x)),
    "type": type,
    "formatDate": formatDate,
    "isActive": isActive,
    "postedByUser": postedByUser.toJson(),
  };
}

class PostedByUser {
  PostedByUser({
    this.id,
    this.completeName,
    this.fullFile,
  });

  String id;
  String completeName;
  String fullFile;

  factory PostedByUser.fromJson(Map<String, dynamic> json) => PostedByUser(
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
