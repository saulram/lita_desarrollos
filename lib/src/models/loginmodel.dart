// To parse this JSON data, do
//
//     final loginResult = loginResultFromJson(jsonString);

import 'dart:convert';

LoginResult loginResultFromJson(String str) => LoginResult.fromJson(json.decode(str));

String loginResultToJson(LoginResult data) => json.encode(data.toJson());

class LoginResult {
    LoginResult({
        this.success,
        this.token,
        this.user,
    });

    bool success;
    String token;
    User user;

    factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
        success: json["success"],
        token: json["token"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "token": token,
        "user": user.toJson(),
    };
}

class User {
    User({
        this.fullFile,
        this.roles,
        this.id,
        this.phone,
        this.departmentId,
        this.email,
        this.completeName,
        this.acceptTerms,
        this.incorrectData,
        this.screenPreferences,
        this.isPhoneActive,
        this.residency,
    });

    String fullFile;
    List<String> roles;
    String id;
    int phone;
    String departmentId;
    String email;
    String completeName;
    bool acceptTerms;
    bool incorrectData;
    List<String> screenPreferences;
    bool isPhoneActive;
    Residency residency;

    factory User.fromJson(Map<String, dynamic> json) => User(
        fullFile: json["fullFile"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        id: json["_id"],
        phone: json["phone"],
        departmentId: json["departmentId"],
        email: json["email"],
        completeName: json["completeName"],
        acceptTerms: json["acceptTerms"],
        incorrectData: json["incorrectData"],
        screenPreferences: List<String>.from(json["screenPreferences"].map((x) => x)),
        isPhoneActive: json["isPhoneActive"],
        residency: Residency.fromJson(json["residency"]),
    );

    Map<String, dynamic> toJson() => {
        "fullFile": fullFile,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "_id": id,
        "phone": phone,
        "departmentId": departmentId,
        "email": email,
        "completeName": completeName,
        "acceptTerms": acceptTerms,
        "incorrectData": incorrectData,
        "screenPreferences": List<dynamic>.from(screenPreferences.map((x) => x)),
        "isPhoneActive": isPhoneActive,
        "residency": residency.toJson(),
    };
}

class Residency {
    Residency({
        this.id,
        this.name,
        this.theme,
    });

    String id;
    String name;
    Theme theme;

    factory Residency.fromJson(Map<String, dynamic> json) => Residency(
        id: json["_id"],
        name: json["name"],
        theme: Theme.fromJson(json["theme"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "theme": theme.toJson(),
    };
}

class Theme {
    Theme({
        this.id,
        this.name,
        this.mainColor,
        this.secondaryColor,
        this.thirdColor,
    });

    String id;
    String name;
    String mainColor;
    String secondaryColor;
    String thirdColor;

    factory Theme.fromJson(Map<String, dynamic> json) => Theme(
        id: json["_id"],
        name: json["name"],
        mainColor: json["mainColor"],
        secondaryColor: json["secondaryColor"],
        thirdColor: json["thirdColor"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mainColor": mainColor,
        "secondaryColor": secondaryColor,
        "thirdColor": thirdColor,
    };
}
