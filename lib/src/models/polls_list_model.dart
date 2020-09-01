// To parse this JSON data, do
//
//     final pollsList = pollsListFromJson(jsonString);

import 'dart:convert';

PollsList pollsListFromJson(String str) => PollsList.fromJson(json.decode(str));

String pollsListToJson(PollsList data) => json.encode(data.toJson());

class PollsList {
  PollsList({
    this.polls,
  });

  List<Poll> polls;

  factory PollsList.fromJson(Map<String, dynamic> json) => PollsList(
    polls: List<Poll>.from(json["polls"].map((x) => Poll.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "polls": List<dynamic>.from(polls.map((x) => x.toJson())),
  };
}

class Poll {
  Poll({
    this.id,
    this.question,
    this.firstOption,
    this.secondOption,
    this.thirdOption,
    this.percent,
    this.updatedAtFormat,
    this.alreadyAnswer,
    this.expiresAtFormat,
  });

  String id;
  String question;
  Option firstOption;
  Option secondOption;
  Option thirdOption;
  Percent percent;
  String updatedAtFormat;
  bool alreadyAnswer;
  String expiresAtFormat;

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
    id: json["_id"],
    question: json["question"],
    firstOption: Option.fromJson(json["firstOption"]),
    secondOption: Option.fromJson(json["secondOption"]),
    thirdOption: Option.fromJson(json["thirdOption"]),
    percent: Percent.fromJson(json["percent"]),
    updatedAtFormat: json["updatedAtFormat"],
    alreadyAnswer: json["alreadyAnswer"],
    expiresAtFormat: json["expiresAtFormat"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "firstOption": firstOption.toJson(),
    "secondOption": secondOption.toJson(),
    "thirdOption": thirdOption.toJson(),
    "percent": percent.toJson(),
    "updatedAtFormat": updatedAtFormat,
    "alreadyAnswer": alreadyAnswer,
    "expiresAtFormat": expiresAtFormat,
  };
}

class Option {
  Option({
    this.answer,
    this.votes,
  });

  String answer;
  List<String> votes;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    answer: json["answer"],
    votes: List<String>.from(json["votes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "answer": answer,
    "votes": List<dynamic>.from(votes.map((x) => x)),
  };
}

class Percent {
  Percent({
    this.firstOption,
    this.secondOption,
    this.thirdOption,
  });

  double firstOption;
  int secondOption;
  double thirdOption;

  factory Percent.fromJson(Map<String, dynamic> json) => Percent(
    firstOption: json["firstOption"].toDouble(),
    secondOption: json["secondOption"],
    thirdOption: json["thirdOption"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "firstOption": firstOption,
    "secondOption": secondOption,
    "thirdOption": thirdOption,
  };
}
