class OrdersStoreModel {
  int? code;
  Data? data;
  String? message;

  OrdersStoreModel({
    this.code,
    this.data,
    this.message,
  });

  factory OrdersStoreModel.fromJson(Map<String, dynamic> json) => OrdersStoreModel(
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  Order? order;
  String? redirectUrl;
  String? paymentSuccess;
  String? paymentaFiled;

  Data({
    this.order,
    this.redirectUrl,
    this.paymentSuccess,
    this.paymentaFiled,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    redirectUrl: json["redirectUrl"],
    paymentSuccess: json["paymentSuccess"],
    paymentaFiled: json["paymentaFiled"],
  );

  Map<String, dynamic> toJson() => {
    "order": order?.toJson(),
    "redirectUrl": redirectUrl,
    "paymentSuccess": paymentSuccess,
    "paymentaFiled": paymentaFiled,
  };
}

class Order {
  int? id;

  Order({
    this.id,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}
