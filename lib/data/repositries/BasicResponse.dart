class BasicResponse {
  String? message;
  int? code;

  BasicResponse({
    this.message,
    this.code,
  });

  factory BasicResponse.fromJson(Map<String, dynamic> json) => BasicResponse(
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
  };
}
