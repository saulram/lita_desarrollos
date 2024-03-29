// To parse this JSON data, do
//
//     final messageList = messageListFromJson(jsonString);

import 'dart:convert';

List<MessageList> messageListFromJson(String str) => List<MessageList>.from(json.decode(str).map((x) => MessageList.fromJson(x)));

String messageListToJson(List<MessageList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageList {
  MessageList({
    this.id,
    this.chatId,
    this.updatedAtFormat,
    this.senderId,
    this.text,
  });

  String id;
  String chatId;
  String updatedAtFormat;
  SenderId senderId;
  String text;

  factory MessageList.fromJson(Map<String, dynamic> json) => MessageList(
    id: json["_id"],
    chatId: json["chatId"],
    updatedAtFormat:json["updatedAtFormat"],
    senderId: SenderId.fromJson(json["senderId"]),
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "chatId": chatId,
    "updatedAt": updatedAtFormat,
    "senderId": senderId.toJson(),
    "text": text,
  };
}

class SenderId {
  SenderId({
    this.id,
    this.completeName,
  });

  String id;
  String completeName;

  factory SenderId.fromJson(Map<String, dynamic> json) => SenderId(
    id: json["_id"],
    completeName: json["completeName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "completeName": completeName,
  };
}
