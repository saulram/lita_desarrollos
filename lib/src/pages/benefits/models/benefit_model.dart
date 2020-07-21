// To parse this JSON data, do
//
//     final exchangeQrBenefit = exchangeQrBenefitFromJson(jsonString);

import 'dart:convert';

ExchangeQrBenefit exchangeQrBenefitFromJson(String str) => ExchangeQrBenefit.fromJson(json.decode(str));

String exchangeQrBenefitToJson(ExchangeQrBenefit data) => json.encode(data.toJson());

class ExchangeQrBenefit {
  ExchangeQrBenefit({
    this.addExchange,
  });

  AddExchange addExchange;

  factory ExchangeQrBenefit.fromJson(Map<String, dynamic> json) => ExchangeQrBenefit(
    addExchange: AddExchange.fromJson(json["addExchange"]),
  );

  Map<String, dynamic> toJson() => {
    "addExchange": addExchange.toJson(),
  };
}

class AddExchange {
  AddExchange({
    this.id,
    this.benefitId,
    this.code,
    this.codeUrl,
    this.exchanged,
    this.updatedAtFormat,
    this.isActive,
  });

  String id;
  BenefitId benefitId;
  String code;
  String codeUrl;
  bool exchanged;
  String updatedAtFormat;
  bool isActive;

  factory AddExchange.fromJson(Map<String, dynamic> json) => AddExchange(
    id: json["_id"],
    benefitId: BenefitId.fromJson(json["benefitId"]),
    code: json["code"],
    codeUrl: json["codeUrl"],
    exchanged: json["exchanged"],
    updatedAtFormat: json["updatedAtFormat"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "benefitId": benefitId.toJson(),
    "code": code,
    "codeUrl": codeUrl,
    "exchanged": exchanged,
    "updatedAtFormat": updatedAtFormat,
    "isActive": isActive,
  };
}

class BenefitId {
  BenefitId({
    this.title,
    this.description,
    this.discount,
  });

  String title;
  dynamic description;
  String discount;

  factory BenefitId.fromJson(Map<String, dynamic> json) => BenefitId(
    title: json["title"],
    description: json["description"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "discount": discount,
  };
}
