// To parse this JSON data, do
//
//     final notificationsList = notificationsListFromJson(jsonString);

import 'dart:convert';

NotificationsList notificationsListFromJson(String str) => NotificationsList.fromJson(json.decode(str));

String notificationsListToJson(NotificationsList data) => json.encode(data.toJson());

class NotificationsList {
  NotificationsList({
    this.notifications,
  });

  List<Notify> notifications;

  factory NotificationsList.fromJson(Map<String, dynamic> json) => NotificationsList(
    notifications: List<Notify>.from(json["notifications"].map((x) => Notify.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
  };
}

class Notify {
  Notify({
    this.id,
    this.title,
    this.description,
    this.customFields,
    this.alreadyRead,
    this.redirectTo,
    this.updatedAtFormat,
  });

  String id;
  String title;
  String description;
  List<CustomField> customFields;
  bool alreadyRead;
  String redirectTo;
  String updatedAtFormat;

  factory Notify.fromJson(Map<String, dynamic> json) => Notify(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    customFields: List<CustomField>.from(json["customFields"].map((x) => CustomField.fromJson(x))),
    alreadyRead: json["alreadyRead"],
    redirectTo: json["redirectTo"],
    updatedAtFormat: json["updatedAtFormat"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "customFields": List<dynamic>.from(customFields.map((x) => x.toJson())),
    "alreadyRead": alreadyRead,
    "redirectTo": redirectTo,
    "updatedAtFormat": updatedAtFormat,
  };
}

class CustomField {
  CustomField({
    this.label,
    this.value,
  });

  String label;
  String value;

  factory CustomField.fromJson(Map<String, dynamic> json) => CustomField(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}
