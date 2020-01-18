class ErrorResponse {
  String status;
  String code;
  String message;

  ErrorResponse({this.status, this.code, this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
        status: json["status"] as String,
        code: json["code"] as String,
        message: json["message"] as String);
  }

  Map toJson() {
    return {"status": status, "code": code, "message": message};
  }
}
