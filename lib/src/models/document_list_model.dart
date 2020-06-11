// To parse this JSON data, do
//
//     final documents = documentsFromJson(jsonString);

import 'dart:convert';

Documents documentsFromJson(String str) => Documents.fromJson(json.decode(str));

String documentsToJson(Documents data) => json.encode(data.toJson());

class Documents {
  Documents({
    this.documents,
  });

  List<Document> documents;

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
    documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
  };
}

class Document {
  Document({
    this.id,
    this.title,
    this.slug,
    this.content,
    this.documentId,
    this.documentUrl,
    this.updatedAtFormat,
  });

  String id;
  String title;
  String slug;
  String content;
  String documentId;
  String documentUrl;
  String updatedAtFormat;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    id: json["_id"],
    title: json["title"],
    slug: json["slug"],
    content: json["content"],
    documentId: json["documentId"],
    documentUrl: json["documentUrl"],
    updatedAtFormat: json["updatedAtFormat"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "slug": slug,
    "content": content,
    "documentId": documentId,
    "documentUrl": documentUrl,
    "updatedAtFormat": updatedAtFormat,
  };
}
