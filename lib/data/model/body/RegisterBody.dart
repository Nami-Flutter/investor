class RegisterBody {
  String? email;
  String? name;
  String? type;
  String? national_num;
  String? nationalty;
  String? experience;
  int? sector_id;
  String? password;
  String? password_confirmation;
  String? phone;
  int? category_id;

  RegisterBody({
    this.email,
    this.password,
    this.phone,
    this.name,
    this.password_confirmation,
    this.experience,
    this.national_num,
    this.nationalty,
    this.sector_id,
    this.type,
    this.category_id,

  });

  factory RegisterBody.fromJson(Map<String, dynamic> json) => RegisterBody(
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    category_id: json["category_id"],
    name: json["name"],
    password_confirmation: json["password_confirmation"],
    experience: json["experience"],
    national_num: json["national_num"],
    nationalty: json["nationalty"],
    sector_id: json["sector_id"],
    type: json["type"],

  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "phone": phone,
    "category_id": category_id,
    "name": name,
    "password_confirmation": password_confirmation,
    "experience": experience,
    "national_num": national_num,
    "nationalty": nationalty,
    "sector_id": sector_id,
    "type": type,

  };
}
