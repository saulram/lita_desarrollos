// To parse this JSON data, do
//
//     final reportCreated = reportCreatedFromJson(jsonString);

import 'dart:convert';

ReportCreated reportCreatedFromJson(String str) => ReportCreated.fromJson(json.decode(str));

String reportCreatedToJson(ReportCreated data) => json.encode(data.toJson());

class ReportCreated {
  ReportCreated({
    this.addComplain,
  });

  AddComplain addComplain;

  factory ReportCreated.fromJson(Map<String, dynamic> json) => ReportCreated(
    addComplain: AddComplain.fromJson(json["addComplain"]),
  );

  Map<String, dynamic> toJson() => {
    "addComplain": addComplain.toJson(),
  };
}

class AddComplain {
  AddComplain({
    this.id,
    this.residencyId,
    this.postedBy,
    this.description,
    this.type,
    this.pictures,
    this.fullFiles,
    this.status,
    this.reportId,
    this.updatedAt,
    this.updatedAtFormat,
    this.createdAt,
    this.isActive,
  });

  String id;
  String residencyId;
  String postedBy;
  String description;
  String type;
  List<String> pictures;
  List<String> fullFiles;
  String status;
  String reportId;
  String updatedAt;
  String updatedAtFormat;
  String createdAt;
  bool isActive;

  factory AddComplain.fromJson(Map<String, dynamic> json) => AddComplain(
    id: json["_id"],
    residencyId: json["residencyId"],
    postedBy: json["postedBy"],
    description: json["description"],
    type: json["type"],
    pictures: List<String>.from(json["pictures"].map((x) => x)),
    fullFiles: List<String>.from(json["fullFiles"].map((x) => x)),
    status: json["status"],
    reportId: json["reportId"],
    updatedAt: json["updatedAt"],
    updatedAtFormat: json["updatedAtFormat"],
    createdAt: json["createdAt"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "residencyId": residencyId,
    "postedBy": postedBy,
    "description": description,
    "type": type,
    "pictures": List<dynamic>.from(pictures.map((x) => x)),
    "fullFiles": List<dynamic>.from(fullFiles.map((x) => x)),
    "status": status,
    "reportId": reportId,
    "updatedAt": updatedAt,
    "updatedAtFormat": updatedAtFormat,
    "createdAt": createdAt,
    "isActive": isActive,
  };
}
