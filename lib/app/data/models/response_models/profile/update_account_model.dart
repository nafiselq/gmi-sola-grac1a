// News Berita Home Response Success
class UpdateAccountResponse {
  UpdateAccountResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  dynamic data;

  factory UpdateAccountResponse.fromJson(Map<String, dynamic> json) {
    return UpdateAccountResponse(
      statusCode: json["status_code"],
      message: json["message"],
      data: json['data'],
    );
  }
}
