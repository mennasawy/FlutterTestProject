import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

SignUpRequest signUpRequestFromJson(String str) =>
    SignUpRequest.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  SignUpRequest({
    this.nameEn,
    this.nameAr,
    this.mobile,
    this.password,
    this.birthdate,
  });

  String nameEn;
  String nameAr;
  String mobile;
  String password;
  String birthdate;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
        nameEn: json["name_en"],
        nameAr: json["name_ar"],
        mobile: json["mobile"],
        password: json["password"],
        birthdate: json["birthdate"],
      );

  Map<String, dynamic> toJson() => {
        "name_en": nameEn,
        "name_ar": nameAr,
        "mobile": mobile,
        "password": password,
        "birthdate": birthdate,
      };
}

SignUpResponse signUpResponseFromJson(String str) =>
    SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  SignUpResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  String status;
  int code;
  String message;
  SignUpResponseData data;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: (json["data"] != null)? SignUpResponseData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class SignUpResponseData {
  SignUpResponseData({
    this.id,
    this.nameAr,
    this.nameEn,
    this.mobile,
    this.birthdate,
    this.apiToken,
    this.createdAt,
  });

  int id;
  String nameAr;
  String nameEn;
  String mobile;
  String birthdate;
  String apiToken;
  List<dynamic> createdAt;

  factory SignUpResponseData.fromJson(Map<String, dynamic> json) => SignUpResponseData(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        mobile: json["mobile"],
        birthdate: json["birthdate"],
        apiToken: json["api_token"],
        createdAt: List<dynamic>.from(json["created_at"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "mobile": mobile,
        "birthdate": birthdate,
        "api_token": apiToken,
        "created_at": List<dynamic>.from(createdAt.map((x) => x)),
      };
}


abstract class SignUpRepository {
  Future<SignUpResponse> userSignUP(SignUpRequest signUpRequestBody,
      BuildContext context, http.Client client);
}