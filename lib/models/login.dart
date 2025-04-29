// To parse this JSON data, do
//
//     final loginUserModel = loginUserModelFromJson(jsonString);

import 'dart:convert';

LoginUserModel loginUserModelFromJson(String str) => LoginUserModel.fromJson(json.decode(str));

String loginUserModelToJson(LoginUserModel data) => json.encode(data.toJson());

class LoginUserModel {
  final String? token;
  final String? message;
  final bool? status;

  LoginUserModel({
    this.token,
    this.message,
    this.status,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) => LoginUserModel(
    token: json["token"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "message": message,
    "status": status,
  };
}
