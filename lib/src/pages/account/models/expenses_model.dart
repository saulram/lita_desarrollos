// To parse this JSON data, do
//
//     final expansesList = expansesListFromJson(jsonString);

import 'dart:convert';

ExpansesList expansesListFromJson(String str) => ExpansesList.fromJson(json.decode(str));

String expansesListToJson(ExpansesList data) => json.encode(data.toJson());

class ExpansesList {
  ExpansesList({
    this.incomesExpenses,
  });

  List<IncomesExpense> incomesExpenses;

  factory ExpansesList.fromJson(Map<String, dynamic> json) => ExpansesList(
    incomesExpenses: List<IncomesExpense>.from(json["incomesExpenses"].map((x) => IncomesExpense.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "incomesExpenses": List<dynamic>.from(incomesExpenses.map((x) => x.toJson())),
  };
}

class IncomesExpense {
  IncomesExpense({
    this.concept,
    this.movementType,
    this.amount,
    this.overdue,
    this.incomeFullFile,
    this.folioNumber,
    this.termPaidDateFormat,
  });

  Concept concept;
  String movementType;
  int amount;
  bool overdue;
  String incomeFullFile;
  dynamic folioNumber;
  String termPaidDateFormat;

  factory IncomesExpense.fromJson(Map<String, dynamic> json) => IncomesExpense(
    concept: Concept.fromJson(json["concept"]),
    movementType: json["movementType"],
    amount: json["amount"],
    overdue: json["overdue"],
    incomeFullFile: json["incomeFullFile"],
    folioNumber: json["folioNumber"],
    termPaidDateFormat: json["termPaidDateFormat"],
  );

  Map<String, dynamic> toJson() => {
    "concept": concept.toJson(),
    "movementType": movementType,
    "amount": amount,
    "overdue": overdue,
    "incomeFullFile": incomeFullFile,
    "folioNumber": folioNumber,
    "termPaidDateFormat": termPaidDateFormat,
  };
}

class Concept {
  Concept({
    this.title,
  });

  String title;

  factory Concept.fromJson(Map<String, dynamic> json) => Concept(
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
  };
}
