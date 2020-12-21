import 'dart:convert';

ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String errorResonseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
    ErrorResponse({
        this.status,
        this.code,
        this.favourite,
        this.message,
    });

    String status;
    int code;
    int favourite;
    String message;

    factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        status: json["status"],
        code: json["code"],
        favourite: json["favourite"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "favourite": favourite,
        "message": message,
    };
}