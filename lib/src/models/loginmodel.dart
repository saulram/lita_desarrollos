// To parse this JSON data, do
//
//     final loginResult = loginResultFromJson(jsonString);

import 'dart:convert';

LoginResult loginResultFromJson(String str) => LoginResult.fromJson(json.decode(str));

String loginResultToJson(LoginResult data) => json.encode(data.toJson());

class LoginResult {
    bool success;
    String token;
    User user;

    LoginResult({
        this.success,
        this.token,
        this.user,
    });

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
    String id;
    List<String> roles;
    bool isPrimaryAccount;
    bool isPhoneActive;
    List<dynamic> screenPreferences;
    bool incorrectData;
    bool acceptTerms;
    bool isDefaulter;
    List<dynamic> fcmTokens;
    List<dynamic> fcmTopics;
    bool isActive;
    String completeName;
    String email;
    Residency residency;

    User({
        this.id,
        this.roles,
        this.isPrimaryAccount,
        this.isPhoneActive,
        this.screenPreferences,
        this.incorrectData,
        this.acceptTerms,
        this.isDefaulter,
        this.fcmTokens,
        this.fcmTopics,
        this.isActive,
        this.completeName,
        this.email,
        this.residency,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        isPrimaryAccount: json["isPrimaryAccount"],
        isPhoneActive: json["isPhoneActive"],
        screenPreferences: List<dynamic>.from(json["screenPreferences"].map((x) => x)),
        incorrectData: json["incorrectData"],
        acceptTerms: json["acceptTerms"],
        isDefaulter: json["isDefaulter"],
        fcmTokens: List<dynamic>.from(json["fcmTokens"].map((x) => x)),
        fcmTopics: List<dynamic>.from(json["fcmTopics"].map((x) => x)),
        isActive: json["isActive"],
        completeName: json["completeName"],
        email: json["email"],
        residency: Residency.fromJson(json["residency"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "isPrimaryAccount": isPrimaryAccount,
        "isPhoneActive": isPhoneActive,
        "screenPreferences": List<dynamic>.from(screenPreferences.map((x) => x)),
        "incorrectData": incorrectData,
        "acceptTerms": acceptTerms,
        "isDefaulter": isDefaulter,
        "fcmTokens": List<dynamic>.from(fcmTokens.map((x) => x)),
        "fcmTopics": List<dynamic>.from(fcmTopics.map((x) => x)),
        "isActive": isActive,
        "completeName": completeName,
        "email": email,
        "residency": residency.toJson(),
    };
}

class Residency {
    String name;
    Theme theme;

    Residency({
        this.name,
        this.theme,
    });

    factory Residency.fromJson(Map<String, dynamic> json) => Residency(
        name: json["name"],
        theme: Theme.fromJson(json["theme"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "theme": theme.toJson(),
    };
}

class Theme {
    String id;
    String secondaryColor;
    String name;
    String mainColor;
    String thirdColor;

    Theme({
        this.id,
        this.secondaryColor,
        this.name,
        this.mainColor,
        this.thirdColor,
    });

    factory Theme.fromJson(Map<String, dynamic> json) => Theme(
        id: json["_id"],
        secondaryColor: json["secondaryColor"],
        name: json["name"],
        mainColor: json["mainColor"],
        thirdColor: json["thirdColor"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "secondaryColor": secondaryColor,
        "name": name,
        "mainColor": mainColor,
        "thirdColor": thirdColor,
    };
}
