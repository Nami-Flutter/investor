class InvestmentLibraryModel {
  int? code;
  List<Data>? data=[];
  String? message;

  InvestmentLibraryModel();

  InvestmentLibraryModel.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    data = json["data"] == null
        ? []
        : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x)));
    message =
    (json["data"] != null) ? json["message"] : json["message"]["error"];
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data,
    "message": message,
  };
}

class Data{
  int? id;
  String? name;
  String? attach;

  Data({
    this.id,
    this.name,
    this.attach

  });
  factory Data.fromJson(Map<String, dynamic>? json) {
    return Data(
      id: json?["id"] ?? '',
      name: json?["name"] ?? '',
      attach: json?["attach"] ?? '',


    );
  }

}





