class ProblemsModel {
  int? code;
  List<Data>? data=[];
  String? message;
  ProblemsModel({
    this.code,
    this.data,
    this.message,
  });

  factory ProblemsModel.fromJson(Map<String, dynamic> json) => ProblemsModel(
    code: json["code"],
    data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
    message: (json["data"]!=null)?json["message"]:json["message"]["error"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data,
    "message": message,
  };
}


class Data{
  String? title;
  int? id;
  Data({this.title,
    this.id,
  });
  factory Data.fromJson(Map<String, dynamic>? json) {
    return Data(
      id: json?["id"] ?? '',
      title: json?["title"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "type": title,
    "id": id,
  };
}