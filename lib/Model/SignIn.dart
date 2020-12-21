import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

SignInResponse loginResponseFromJson(String str) =>
    SignInResponse.fromJson(json.decode(str));

String loginResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
  SignInResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  String status;
  int code;
  String message;
  SignInResponseData data;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: (json["data"] != null) ? SignInResponseData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class SignInResponseData {
  SignInResponseData({
    this.userid,
    this.nameAr,
    this.nameEn,
    this.mobile,
    this.birthdate,
    this.createdAt,
  });

  int userid;
  String nameAr;
  String nameEn;
  String mobile;
  DateTime birthdate;
  List<dynamic> createdAt;

  factory SignInResponseData.fromJson(Map<String, dynamic> json) => SignInResponseData(
        userid: json["userid"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        mobile: json["mobile"],
        birthdate: DateTime.parse(json["birthdate"]),
        createdAt: List<dynamic>.from(json["created_at"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "name_ar": nameAr,
        "name_en": nameEn,
        "mobile": mobile,
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "created_at": List<dynamic>.from(createdAt.map((x) => x)),
      };
}



SignInRequest loginRequestFromJson(String str) => SignInRequest.fromJson(json.decode(str));

String loginRequestToJson(SignInRequest data) => json.encode(data.toJson());

class SignInRequest {
    SignInRequest({
        this.mobile,
        this.password,
    });

    String mobile;
    String password;

    factory SignInRequest.fromJson(Map<String, dynamic> json) => SignInRequest(
        mobile: json["mobile"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "password": password,
    };
}

abstract class SignInRepository {
  Future<SignInResponse> userSignIn(SignInRequest loginRequestBody,
      BuildContext context, http.Client client);
}