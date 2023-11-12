// News Berita Home Response Success
class DetailIbadahResponse {
  DetailIbadahResponse({
    this.statusCode,
    this.message,
    this.ibadahDetail,
  });

  int? statusCode;
  String? message;
  List<ListDataIbadaDetail>? ibadahDetail;

  factory DetailIbadahResponse.fromJson(Map<String, dynamic> json) {
    return DetailIbadahResponse(
      statusCode: json["status_code"],
      message: json["message"],
      ibadahDetail: json['data'] == null
          ? null
          : List<ListDataIbadaDetail>.from(
              json["data"].map(
                (x) => ListDataIbadaDetail.fromJson(x),
              ),
            ),
    );
  }
}

class ListDataIbadaDetail {
  ListDataIbadaDetail({
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
  String? date;
  String? startAt;
  String? endAt;
  String? youtube;

  factory ListDataIbadaDetail.fromJson(Map<String, dynamic> json) =>
      ListDataIbadaDetail(
        id: json["id"],
        title: json['title'],
        thumbnail: json['thumbnail'],
        date: json['date'],
        startAt: json['start_at'],
        endAt: json['end_at'],
        youtube: json['youtube'],
      );
}
