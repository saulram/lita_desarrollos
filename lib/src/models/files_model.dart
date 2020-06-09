// To parse this JSON data, do
//
//     final filesUploaded = filesUploadedFromJson(jsonString);

import 'dart:convert';

FilesUploaded filesUploadedFromJson(String str) => FilesUploaded.fromJson(json.decode(str));

String filesUploadedToJson(FilesUploaded data) => json.encode(data.toJson());

class FilesUploaded {
  FilesUploaded({
    this.status,
    this.fileNames,
  });

  String status;
  List<String> fileNames;

  factory FilesUploaded.fromJson(Map<String, dynamic> json) => FilesUploaded(
    status: json["status"],
    fileNames: List<String>.from(json["fileNames"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "fileNames": List<dynamic>.from(fileNames.map((x) => x)),
  };
}
