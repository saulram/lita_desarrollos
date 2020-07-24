// To parse this JSON data, do
//
//     final voteList = voteListFromJson(jsonString);

import 'dart:convert';

VoteList voteListFromJson(String str) => VoteList.fromJson(json.decode(str));

String voteListToJson(VoteList data) => json.encode(data.toJson());

class VoteList {
  VoteList({
    this.votes,
  });

  List<Vote> votes;

  factory VoteList.fromJson(Map<String, dynamic> json) => VoteList(
    votes: List<Vote>.from(json["votes"].map((x) => Vote.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "votes": List<dynamic>.from(votes.map((x) => x.toJson())),
  };
}

class Vote {
  Vote({
    this.id,
    this.residencyId,
    this.title,
    this.description,
    this.percent,
    this.alreadyAnswer,
    this.updatedAtFormat,
    this.expiresAtLFormat,
    this.expiresAtFormat,
  });

  String id;
  String residencyId;
  String title;
  String description;
  Percent percent;
  bool alreadyAnswer;
  String updatedAtFormat;
  DateTime expiresAtLFormat;
  String expiresAtFormat;

  factory Vote.fromJson(Map<String, dynamic> json) => Vote(
    id: json["_id"],
    residencyId: json["residencyId"],
    title: json["title"],
    description: json["description"],
    percent: Percent.fromJson(json["percent"]),
    alreadyAnswer: json["alreadyAnswer"],
    updatedAtFormat: json["updatedAtFormat"],
    expiresAtLFormat: DateTime.parse(json["expiresAtLFormat"]),
    expiresAtFormat: json["expiresAtFormat"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "residencyId": residencyId,
    "title": title,
    "description": description,
    "percent": percent.toJson(),
    "alreadyAnswer": alreadyAnswer,
    "updatedAtFormat": updatedAtFormat,
    "expiresAtLFormat": expiresAtLFormat.toIso8601String(),
    "expiresAtFormat": expiresAtFormat,
  };
}

class Percent {
  Percent({
    this.upVote,
    this.downVote,
  });

  int upVote;
  int downVote;

  factory Percent.fromJson(Map<String, dynamic> json) => Percent(
    upVote: json["upVote"],
    downVote: json["downVote"],
  );

  Map<String, dynamic> toJson() => {
    "upVote": upVote,
    "downVote": downVote,
  };
}
