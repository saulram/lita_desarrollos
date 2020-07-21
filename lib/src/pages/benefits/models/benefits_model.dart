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
    this.benefits,
  });

  String id;
  String name;
  List<Benefit> benefits;

  factory CategoriesBenefit.fromJson(Map<String, dynamic> json) => CategoriesBenefit(
    id: json["_id"],
    name: json["name"],
    benefits: List<Benefit>.from(json["benefits"].map((x) => Benefit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "benefits": List<dynamic>.from(benefits.map((x) => x.toJson())),
  };
}

class Benefit {
  Benefit({
    this.id,
    this.title,
    this.description,
    this.picture,
    this.fullFile,
    this.discount,
    this.company,
    this.until,
    this.phone,
    this.website,
    this.updatedAtFormat,
  });

  String id;
  String title;
  String description;
  String picture;
  String fullFile;
  String discount;
  String company;
  String until;
  String phone;
  String website;
  String updatedAtFormat;

  factory Benefit.fromJson(Map<String, dynamic> json) => Benefit(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    picture: json["picture"],
    fullFile: json["fullFile"],
    discount: json["discount"],
    company: json["company"],
    until: json["until"],
    phone: json["phone"],
    website: json["website"],
    updatedAtFormat: json["updatedAtFormat"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "picture": picture,
    "fullFile": fullFile,
    "discount": discount,
    "company": company,
    "until": until,
    "phone": phone,
    "website": website,
    "updatedAtFormat": updatedAtFormat,
  };
}
