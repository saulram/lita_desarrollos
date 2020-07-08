// To parse this JSON data, do
//
//     final wallsList = wallsListFromJson(jsonString);

import 'dart:convert';

WallsList wallsListFromJson(String str) => WallsList.fromJson(json.decode(str));

String wallsListToJson(WallsList data) => json.encode(data.toJson());

class WallsList {
  WallsList({
    this.walls,
  });

  List<Wall> walls;

  factory WallsList.fromJson(Map<String, dynamic> json) => WallsList(
    walls: List<Wall>.from(json["walls"].map((x) => Wall.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "walls": List<dynamic>.from(walls.map((x) => x.toJson())),
  };
}

class Wall {
  Wall({
    this.id,
    this.postedById,
    this.fullFiles,
    this.description,
    this.updateAtFormat,
    this.isActive,
    this.comments,
  });

  String id;
  PostedById postedById;
  List<String> fullFiles;
  String description;
  String updateAtFormat;
  bool isActive;
  List<Comment> comments;

  factory Wall.fromJson(Map<String, dynamic> json) => Wall(
    id: json["_id"],
    postedById: PostedById.fromJson(json["postedById"]),
    fullFiles: List<String>.from(json["fullFiles"].map((x) => x)),
    description: json["description"],
    updateAtFormat: json["updateAtFormat"],
    isActive: json["isActive"],
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "postedById": postedById.toJson(),
    "fullFiles": List<dynamic>.from(fullFiles.map((x) => x)),
    "description": description,
    "updateAtFormat": updateAtFormat,
    "isActive": isActive,
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}

class Comment {
  Comment({
    this.id,
    this.text,
    this.postedAtFormatDate,
    this.postedById,
    this.replayIds,
  });

  String id;
  String text;
  String postedAtFormatDate;
  PostedById postedById;
  List<ReplayId> replayIds;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["_id"],
    text: json["text"],
    postedAtFormatDate: json["postedAtFormatDate"],
    postedById: PostedById.fromJson(json["postedById"]),
    replayIds: List<ReplayId>.from(json["replayIds"].map((x) => ReplayId.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "text": text,
    "postedAtFormatDate": postedAtFormatDate,
    "postedById": postedById.toJson(),
    "replayIds": List<dynamic>.from(replayIds.map((x) => x.toJson())),
  };
}

class PostedById {
  PostedById({
    this.id,
    this.completeName,
    this.fullFile,
  });

  String id;
  String completeName;
  String fullFile;

  factory PostedById.fromJson(Map<String, dynamic> json) => PostedById(
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

class ReplayId {
  ReplayId({
    this.id,
    this.text,
    this.postedById,
  });

  String id;
  String text;
  PostedById postedById;

  factory ReplayId.fromJson(Map<String, dynamic> json) => ReplayId(
    id: json["_id"],
    text: json["text"],
    postedById: PostedById.fromJson(json["postedById"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "text": text,
    "postedById": postedById.toJson(),
  };
}
