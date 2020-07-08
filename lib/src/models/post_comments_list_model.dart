// To parse this JSON data, do
//
//     final postModelCommentsDetail = postModelCommentsDetailFromJson(jsonString);

import 'dart:convert';

PostModelCommentsDetail postModelCommentsDetailFromJson(String str) => PostModelCommentsDetail.fromJson(json.decode(str));

String postModelCommentsDetailToJson(PostModelCommentsDetail data) => json.encode(data.toJson());

class PostModelCommentsDetail {
  PostModelCommentsDetail({
    this.comments,
  });

  List<Comment> comments;

  factory PostModelCommentsDetail.fromJson(Map<String, dynamic> json) => PostModelCommentsDetail(
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
  };
}

class Comment {
  Comment({
    this.id,
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
  String wallId;
  String text;
  List<ReplayId> replayIds;
  PostedById postedById;
  List<dynamic> complainById;
  String postedAt;
  String postedAtFormatDate;
  bool isActive;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["_id"],
    wallId: json["wallId"],
    text: json["text"],
    replayIds: List<ReplayId>.from(json["replayIds"].map((x) => ReplayId.fromJson(x))),
    postedById: PostedById.fromJson(json["postedById"]),
    complainById: List<dynamic>.from(json["complainById"].map((x) => x)),
    postedAt: json["postedAt"],
    postedAtFormatDate: json["postedAtFormatDate"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "wallId": wallId,
    "text": text,
    "replayIds": List<dynamic>.from(replayIds.map((x) => x.toJson())),
    "postedById": postedById.toJson(),
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

class ReplayId {
  ReplayId({
    this.id,
    this.text,
    this.postedById,
    this.replayIds,
  });

  String id;
  String text;
  PostedById postedById;
  List<dynamic> replayIds;

  factory ReplayId.fromJson(Map<String, dynamic> json) => ReplayId(
    id: json["_id"],
    text: json["text"],
    postedById: PostedById.fromJson(json["postedById"]),
    replayIds: List<dynamic>.from(json["replayIds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "text": text,
    "postedById": postedById.toJson(),
    "replayIds": List<dynamic>.from(replayIds.map((x) => x)),
  };
}
