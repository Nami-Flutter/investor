class CategoriesModel {
  int? code;
  List<Data>? data;
  String? message;

  CategoriesModel({
    this.code,
    this.data,
    this.message,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) => CategoriesModel(
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