// To parse this JSON data, do
//
// final userProfileModel = userProfileModelFromJson(jsonString);
import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => 
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => 
    json.encode(data.toJson());

class UserProfileModel {
  String? result;
  String? msg;
  Data? data;

  UserProfileModel({
    this.result,
    this.msg,
    this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => 
      UserProfileModel(
        result: json["result"]?.toString(),
        msg: json["msg"]?.toString(),
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class Data {
  String? userId;
  String? countryCode;
  String? mobileNo;
  String? firstName;
  String? lastName;
  String? name;
  String? email;
  DateTime? updateAt;

  Data({
    this.userId,
    this.countryCode,
    this.mobileNo,
    this.firstName,
    this.lastName,
    this.name,
    this.email,
    this.updateAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["_id"]?.toString() ?? json["userId"]?.toString(),
        countryCode: json["country_code"]?.toString(),
        mobileNo: json["mobile_no"]?.toString(),
        firstName: json["firstName"]?.toString(),
        lastName: json["lastName"]?.toString(),
        name: json["name"]?.toString(),
        email: json["email"]?.toString(),
        updateAt: json["updatedAt"] != null 
            ? DateTime.tryParse(json["updatedAt"].toString()) 
            : json["updateAt"] != null 
                ? DateTime.tryParse(json["updateAt"].toString()) 
                : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": userId,
        "userId": userId,
        "country_code": countryCode,
        "mobile_no": mobileNo,
        "firstName": firstName,
        "lastName": lastName,
        "name": name,
        "email": email,
        "updatedAt": updateAt?.toIso8601String(),
        "updateAt": updateAt?.toIso8601String(),
      };
}