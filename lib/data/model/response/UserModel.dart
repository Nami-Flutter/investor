
class UserModel {
  int? code;
  Data? data;
  String? message;

  UserModel();

   UserModel.fromJson(Map<String, dynamic> json) {
    code= json["code"];
    data= json["data"] == null ? null : Data.fromJson(json["data"]);
    message= (json["data"]!=null)?json["message"]:json["message"]["error"];

   }

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
    "message": message,
  };
}


class Data{
  Category? category;
  Sector? sector;
  String? type;
  String? email;
  int? id;
  String? name;
  String? token;
  String? phone;
  String? national_num;
  String? nationalty;
  String? experience;
  String? image;
  int? experience_year;
  Data({this.email,
    this.id,
    this.name,
    this.token,
    this.experience_year,
    this.experience,
    this.national_num,
    this.nationalty,
    this.phone,
    this.type,
    this.sector,
    this.category,
    this.image
  });
  factory Data.fromJson(Map<String, dynamic>? json) {
    return Data(
      type: json?["type"] ?? '',
      id: json?["id"] ?? '',
      name: json?["name"] ?? '',
      token: json?["token"] ?? '',
      national_num: json?["national_num"] ?? '',
      phone: json?["phone"] ?? '',
      nationalty: json?["nationalty"] ?? '',
      email: json?["email"] ?? '',
      experience: json?["experience"] ?? '',
      experience_year: json?["experience_year"] ?? '',
      image: json?["image"] ?? '',
        category:  json?["category"] == null ? null : Category.fromJson(json?["category"]),
      sector:  json?["sector"] == null ? null : Sector.fromJson(json?["sector"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
    "name": name,
    "token": token,
    "experience_year": experience_year,
    "email": email,
    "national_num": national_num,
    "phone": phone,
    "nationalty": nationalty,
    "experience": experience,
    "category": experience,
    "sector": experience,
    "image": image,

  };
}


class Sector{
  String? title;
  int? id;
  Sector({this.title,
    this.id,
    });
  factory Sector.fromJson(Map<String, dynamic>? json) {
    return Sector(
      id: json?["id"] ?? '',
      title: json?["title"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "type": title,
    "id": id,
  };
}

class Category{
  String? title;
  int? id;
  Category({this.title,
    this.id,
    });
  factory Category.fromJson(Map<String, dynamic>? json) {
    return Category(
      id: json?["id"] ?? '',
      title: json?["title"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "type": title,
    "id": id,
  };
}

