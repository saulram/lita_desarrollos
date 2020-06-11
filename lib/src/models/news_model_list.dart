// To parse this JSON data, do
//
//     final newsList = newsListFromJson(jsonString);

import 'dart:convert';

NewsList newsListFromJson(String str) => NewsList.fromJson(json.decode(str));

String newsListToJson(NewsList data) => json.encode(data.toJson());

class NewsList {
  NewsList({
    this.news,
  });

  List<News> news;

  factory NewsList.fromJson(Map<String, dynamic> json) => NewsList(
    news: List<News>.from(json["news"].map((x) => News.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "news": List<dynamic>.from(news.map((x) => x.toJson())),
  };
}

class News {
  News({
    this.residencyId,
    this.id,
    this.title,
    this.description,
    this.images,
    this.fullFiles,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.updatedAtFormat,
  });

  String residencyId;
  String id;
  String title;
  String description;
  List<String> images;
  List<String> fullFiles;
  bool isActive;
  String createdAt;
  String updatedAt;
  String updatedAtFormat;

  factory News.fromJson(Map<String, dynamic> json) => News(
    residencyId: json["residencyId"],
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    images: List<String>.from(json["images"].map((x) => x)),
    fullFiles: List<String>.from(json["fullFiles"].map((x) => x)),
    isActive: json["isActive"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    updatedAtFormat: json["updatedAtFormat"],
  );

  Map<String, dynamic> toJson() => {
    "residencyId": residencyId,
    "_id": id,
    "title": title,
    "description": description,
    "images": List<dynamic>.from(images.map((x) => x)),
    "fullFiles": List<dynamic>.from(fullFiles.map((x) => x)),
    "isActive": isActive,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "updatedAtFormat": updatedAtFormat,
  };
}
