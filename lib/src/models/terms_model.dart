// To parse this JSON data, do
//
//     final terms = termsFromJson(jsonString);

import 'dart:convert';

Terms termsFromJson(String str) => Terms.fromJson(json.decode(str));

String termsToJson(Terms data) => json.encode(data.toJson());

class Terms {
    GlobalContent globalContent;

    Terms({
        this.globalContent,
    });

    factory Terms.fromJson(Map<String, dynamic> json) => Terms(
        globalContent: GlobalContent.fromJson(json["globalContent"]),
    );

    Map<String, dynamic> toJson() => {
        "globalContent": globalContent.toJson(),
    };
}

class GlobalContent {
    String id;
    String title;
    String slug;
    String content;
    String createdAt;
    String updatedAtFormatDate;
    bool isActive;

    GlobalContent({
        this.id,
        this.title,
        this.slug,
        this.content,
        this.createdAt,
        this.updatedAtFormatDate,
        this.isActive,
    });

    factory GlobalContent.fromJson(Map<String, dynamic> json) => GlobalContent(
        id: json["_id"],
        title: json["title"],
        slug: json["slug"],
        content: json["content"],
        createdAt: json["createdAt"],
        updatedAtFormatDate: json["updatedAtFormatDate"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "slug": slug,
        "content": content,
        "createdAt": createdAt,
        "updatedAtFormatDate": updatedAtFormatDate,
        "isActive": isActive,
    };
}
