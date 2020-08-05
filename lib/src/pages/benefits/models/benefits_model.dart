// To parse this JSON data, do
//
//     final benefitsList = benefitsListFromJson(jsonString);

import 'dart:convert';

BenefitsList benefitsListFromJson(String str) => BenefitsList.fromJson(json.decode(str));

String benefitsListToJson(BenefitsList data) => json.encode(data.toJson());

class BenefitsList {
  BenefitsList({
    this.categoriesBenefits,
  });

  List<CategoriesBenefit> categoriesBenefits;

  factory BenefitsList.fromJson(Map<String, dynamic> json) => BenefitsList(
    categoriesBenefits: List<CategoriesBenefit>.from(json["categoriesBenefits"].map((x) => CategoriesBenefit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categoriesBenefits": List<dynamic>.from(categoriesBenefits.map((x) => x.toJson())),
  };
}

class CategoriesBenefit {
  CategoriesBenefit({
    this.id,
    this.name,
    this.updatedAtFormat,
    this.benefits,
  });

  String id;
  String name;
  dynamic updatedAtFormat;
  List<Benefit> benefits;

  factory CategoriesBenefit.fromJson(Map<String, dynamic> json) => CategoriesBenefit(
    id: json["_id"],
    name: json["name"],
    updatedAtFormat: json["updatedAtFormat"],
    benefits: List<Benefit>.from(json["benefits"].map((x) => Benefit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "updatedAtFormat": updatedAtFormat,
    "benefits": List<dynamic>.from(benefits.map((x) => x.toJson())),
  };
}

class Benefit {
  Benefit({
    this.id,
    this.title,
    this.picture,
    this.fullFile,
    this.discount,
    this.company,
    this.until,
    this.phone,
    this.website,
    this.updatedAtFormat,
    this.branch,
  });

  String id;
  String title;
  String picture;
  String fullFile;
  String discount;
  String company;
  String until;
  String phone;
  String website;
  String updatedAtFormat;
  String branch;

  factory Benefit.fromJson(Map<String, dynamic> json) => Benefit(
    id: json["_id"],
    title: json["title"],
    picture: json["picture"],
    fullFile: json["fullFile"],
    discount: json["discount"],
    company: json["company"],
    until: json["until"],
    phone: json["phone"] == null ? null : json["phone"],
    website: json["website"],
    updatedAtFormat: json["updatedAtFormat"],
    branch: json["branch"] == null ? null : json["branch"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "picture": picture,
    "fullFile": fullFile,
    "discount": discount,
    "company": company,
    "until": until,
    "phone": phone == null ? null : phone,
    "website": website,
    "updatedAtFormat": updatedAtFormat,
    "branch": branch == null ? null : branch,
  };
}
