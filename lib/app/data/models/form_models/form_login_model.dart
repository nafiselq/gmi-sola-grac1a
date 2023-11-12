class FormLoginModel {
  final String? username;
  final String? password;

  FormLoginModel({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory FormLoginModel.fromJson(Map<String, dynamic> json) => FormLoginModel(
        username: json['username'],
        password: json['password'],
      );
}
