class InvestmentToursModel {
  int? code;
  List<Data>? data;
  String? message;

  InvestmentToursModel({
    this.code,
    this.data,
    this.message,
  });

  factory InvestmentToursModel.fromJson(Map<String, dynamic> json) => InvestmentToursModel(
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
  String? details;
  int? id;

  Data({this.title,
    this.id,
    this.details
  });
  factory Data.fromJson(Map<String, dynamic>? json) {
    return Data(
      id: json?["id"] ?? '',
      title: json?["title"] ?? '',
      details: json?["details"] ?? '',
    );
  }

}