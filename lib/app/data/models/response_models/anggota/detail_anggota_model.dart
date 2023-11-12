// News Berita Home Response Success
class DetailAnggotaResponse {
  DetailAnggotaResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  int? statusCode;
  String? message;
  List<ListDataAnggotaDetail>? data;

  factory DetailAnggotaResponse.fromJson(Map<String, dynamic> json) {
    return DetailAnggotaResponse(
      statusCode: json["status_code"],
      message: json["message"],
      data: json['data'] == null
          ? null
          : List<ListDataAnggotaDetail>.from(
              json["data"].map(
                (x) => ListDataAnggotaDetail.fromJson(x),
              ),
            ),
    );
  }
}

class ListDataAnggotaDetail {
  ListDataAnggotaDetail({
    this.title,
    this.value,
  });

  String? title;
  dynamic value;
  factory ListDataAnggotaDetail.fromJson(Map<String, dynamic> json) =>
      ListDataAnggotaDetail(
        title: json['title'],
        value: json['value'],
      );
}
