// To parse this JSON data, do
//
//     final chatList = chatListFromJson(jsonString);

import 'dart:convert';

ChatList chatListFromJson(String str) => ChatList.fromJson(json.decode(str));

String chatListToJson(ChatList data) => json.encode(data.toJson());

class ChatList {
  ChatList({
    this.chats,
  });

  List<Chat> chats;

  factory ChatList.fromJson(Map<String, dynamic> json) => ChatList(
    chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chats": List<dynamic>.from(chats.map((x) => x.toJson())),
  };
}

class Chat {
  Chat({
    this.id,
    this.users,
    this.name,
    this.isActive,
  });

  String id;
  List<User> users;
  String name;
  bool isActive;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["_id"],
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
    name: json["name"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
    "name": name,
    "isActive": isActive,
  };
}

class User {
  User({
    this.id,
    this.completeName,
    this.fullFile,
  });

  String id;
  String completeName;
  String fullFile;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
