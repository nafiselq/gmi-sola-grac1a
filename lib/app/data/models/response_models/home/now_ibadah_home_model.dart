// Now Ibadah Home Response Success
class NowIbadahHomeResponse {
  NowIbadahHomeResponse({this.statusCode, this.message, this.data});

  int? statusCode;
  String? message;
  Ibadah? data;

  factory NowIbadahHomeResponse.fromJson(Map<String, dynamic> json) {
    return NowIbadahHomeResponse(
      statusCode: json["status_code"],
      message: json["message"],
      data: Ibadah.fromJson(json['data']),
    );
  }
}

class Ibadah {
  Ibadah({
    this.id,
    this.title,
    this.thumbnail,
    this.date,
    this.startAt,
    this.endAt,
    this.youtube,
  });

  int? id;
  String? title;
  String? thumbnail;
  DateTime? date;
  String? startAt;
  String? endAt;
  String? youtube;

  factory Ibadah.fromJson(Map<String, dynamic> json) => Ibadah(
        id: json["id"],
        title: json['title'],
        thumbnail: json['thumbnail'],
        date: DateTime.parse(json['date']),
        startAt: json['start_at'],
        endAt: json['end_at'],
        youtube: json['youtube'],
      );
}

class ErrorIbadahNow {
  ErrorIbadahNow({
    this.statusCode,
    this.message,
    this.data,
    this.stack,
  });

  int? statusCode;
  String? message;
  String? data;
  String? stack;

  factory ErrorIbadahNow.fromJson(Map<String, dynamic> json) => ErrorIbadahNow(
        statusCode: json['status_code'],
        message: json['message'],
        data: json['data'] == null ? '' : json['data'],
        stack: json['stack'] == null ? '' : json['stck'],
      );
}
