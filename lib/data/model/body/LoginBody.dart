class LoginBody {
  String? email;
  String? password;

  LoginBody({
    this.email,
    this.password,
  });

  factory LoginBody.fromJson(Map<String, dynamic> json) => LoginBody(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
