// Now Ibadah Home Response Success
class SubmitPresenceHomeResponse {
  SubmitPresenceHomeResponse({this.statusCode, this.message, this.data});

  int? statusCode;
  String? message;
  Ibadah? data;

  factory SubmitPresenceHomeResponse.fromJson(Map<String, dynamic> json) {
    return SubmitPresenceHomeResponse(
      statusCode: json["status_code"],
      message: json["message"],
      data: json['data'] == null ? null : Ibadah.fromJson(json['data'][0]),
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

class ErrorSubmitPresence {
  ErrorSubmitPresence({
    this.statusCode,
    this.message,
    this.data,
    this.stack,
  });

  int? statusCode;
  String? message;
  String? data;
  String? stack;

  factory ErrorSubmitPresence.fromJson(Map<String, dynamic> json) =>
      ErrorSubmitPresence(
        statusCode: json['status_code'],
        message: json['message'],
        data: json['data'] == null ? '' : json['data'],
        stack: json['stack'] == null ? '' : json['stck'],
      );
}
