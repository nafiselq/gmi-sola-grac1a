// Login Success
class LoginResponse {
  LoginResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  Data? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      statusCode: json["status_code"],
      message: json["message"],
      data: json['data'] == null ? null : Data.fromJson(json["data"]),
    );
  }
}

class Data {
  Data({
    this.token,
    this.detailData,
  });

  String? token;
  DetailData? detailData;

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(token: json["token"], detailData: DetailData.fromJson(json['item']));

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'item': detailData,
    };
  }
}

//Detail Data
class DetailData {
  DetailData({
    this.id,
    this.username,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? username;
  int? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DetailData.fromJson(Map<String, dynamic> json) => DetailData(
        id: json['id'],
        username: json['username'],
        role: json['role'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
