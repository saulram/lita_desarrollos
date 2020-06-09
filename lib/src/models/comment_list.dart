// To parse this JSON data, do
//
//     final commentList = commentListFromJson(jsonString);

import 'dart:convert';

CommentList commentListFromJson(String str) => CommentList.fromJson(json.decode(str));

String commentListToJson(CommentList data) => json.encode(data.toJson());

class CommentList {
  CommentList({
    this.comments,
  });

  List<Comment> comments;

  factory CommentList.fromJson(Map<String, dynamic> json) => CommentList(
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}

class Comment {
  Comment({
    this.id,
    this.bazaarId,
    this.wallId,
    this.text,
    this.replayIds,
    this.postedById,
    this.complainById,
    this.postedAt,
    this.postedAtFormatDate,
    this.isActive,
  });

  String id;
  dynamic bazaarId;
  dynamic wallId;
  String text;
  List<dynamic> replayIds;
  PostedById postedById;
  List<String> complainById;
  String postedAt;
  String postedAtFormatDate;
  bool isActive;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["_id"],
    bazaarId: json["bazaarId"],
    wallId: json["wallId"],
    text: json["text"],
    replayIds: List<dynamic>.from(json["replayIds"].map((x) => x)),
    postedById: json["postedById"] == null ? null : PostedById.fromJson(json["postedById"]),
    complainById: List<String>.from(json["complainById"].map((x) => x)),
    postedAt: json["postedAt"],
    postedAtFormatDate: json["postedAtFormatDate"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bazaarId": bazaarId,
    "wallId": wallId,
    "text": text,
    "replayIds": List<dynamic>.from(replayIds.map((x) => x)),
    "postedById": postedById == null ? null : postedById.toJson(),
    "complainById": List<dynamic>.from(complainById.map((x) => x)),
    "postedAt": postedAt,
    "postedAtFormatDate": postedAtFormatDate,
    "isActive": isActive,
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
