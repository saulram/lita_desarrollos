// To parse this JSON data, do
//
//     final commonAreasList = commonAreasListFromJson(jsonString);

import 'dart:convert';

CommonAreasList commonAreasListFromJson(String str) => CommonAreasList.fromJson(json.decode(str));

String commonAreasListToJson(CommonAreasList data) => json.encode(data.toJson());

class CommonAreasList {
  CommonAreasList({
    this.commonAreas,
  });

  List<CommonArea> commonAreas;

  factory CommonAreasList.fromJson(Map<String, dynamic> json) => CommonAreasList(
    commonAreas: List<CommonArea>.from(json["commonAreas"].map((x) => CommonArea.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "commonAreas": List<dynamic>.from(commonAreas.map((x) => x.toJson())),
  };
}

class CommonArea {
  CommonArea({
    this.id,
    this.name,
    this.picture,
    this.fullFiles,
    this.description,
    this.schedule,
    this.regulationTitle,
    this.regulationContent,
    this.regulationFile,
    this.regulationFileUrl,
    this.cost,
    this.opensAt,
    this.closesAt,
    this.scheduleInterval,
    this.createdAt,
    this.updatedAt,
    this.formatDate,
  });

  String id;
  String name;
  List<String> picture;
  List<String> fullFiles;
  String description;
  String schedule;
  String regulationTitle;
  String regulationContent;
  String regulationFile;
  String regulationFileUrl;
  int cost;
  String opensAt;
  String closesAt;
  int scheduleInterval;
  String createdAt;
  String updatedAt;
  String formatDate;

  factory CommonArea.fromJson(Map<String, dynamic> json) => CommonArea(
    id: json["_id"],
    name: json["name"],
    picture: List<String>.from(json["picture"].map((x) => x)),
    fullFiles: List<String>.from(json["fullFiles"].map((x) => x)),
    description: json["description"],
    schedule: json["schedule"],
    regulationTitle: json["regulationTitle"],
    regulationContent: json["regulationContent"],
    regulationFile: json["regulationFile"],
    regulationFileUrl: json["regulationFileUrl"],
    cost: json["cost"],
    opensAt: json["opensAt"],
    closesAt: json["closesAt"],
    scheduleInterval: json["scheduleInterval"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    formatDate: json["formatDate"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "picture": List<dynamic>.from(picture.map((x) => x)),
    "fullFiles": List<dynamic>.from(fullFiles.map((x) => x)),
    "description": description,
    "schedule": schedule,
    "regulationTitle": regulationTitle,
    "regulationContent": regulationContent,
    "regulationFile": regulationFile,
    "regulationFileUrl": regulationFileUrl,
    "cost": cost,
    "opensAt": opensAt,
    "closesAt": closesAt,
    "scheduleInterval": scheduleInterval,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "formatDate": formatDate,
  };
}
