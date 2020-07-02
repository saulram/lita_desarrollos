// To parse this JSON data, do
//
//     final areaSchedule = areaScheduleFromJson(jsonString);

import 'dart:convert';

AreaSchedule areaScheduleFromJson(String str) => AreaSchedule.fromJson(json.decode(str));

String areaScheduleToJson(AreaSchedule data) => json.encode(data.toJson());

class AreaSchedule {
  AreaSchedule({
    this.availability,
  });

  Availability availability;

  factory AreaSchedule.fromJson(Map<String, dynamic> json) => AreaSchedule(
    availability: Availability.fromJson(json["availability"]),
  );

  Map<String, dynamic> toJson() => {
    "availability": availability.toJson(),
  };
}

class Availability {
  Availability({
    this.schedule,
    this.error,
  });

  List<String> schedule;
  String error;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    schedule: List<String>.from(json["schedule"].map((x) => x)),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "schedule": List<dynamic>.from(schedule.map((x) => x)),
    "error": error,
  };
}
