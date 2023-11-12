// News Berita Home Response Success
class ListIbadahResponse {
  ListIbadahResponse({
    this.statusCode,
    this.message,
    this.currentPage,
    this.from,
    this.lastPage,
    this.total,
    this.data,
  });

  int? statusCode;
  String? message;
  int? currentPage;
  int? from;
  int? lastPage;
  int? total;
  List<ListDataIbadah>? data;

  factory ListIbadahResponse.fromJson(Map<String, dynamic> json) {
    return ListIbadahResponse(
      statusCode: json["status_code"],
      message: json["message"],
      currentPage: json['data'] == null ? 0 : json['data']['current_page'],
      from: json['data'] == null ? 0 : json['data']['from'],
      lastPage: json['data'] == null ? 0 : json['data']['last_page'],
      total: json['data'] == null ? 0 : json['data']['total'],
      data: json['data'] == null
          ? null
          : List<ListDataIbadah>.from(
              json["data"]["data"].map(
                (x) => ListDataIbadah.fromJson(x),
              ),
            ),
    );
  }
}

class ListDataIbadah {
  ListDataIbadah({
    this.title,
    this.thumbnail,
    this.date,
    this.time,
  });

  String? title;
  String? thumbnail;
  String? date;
  String? time;

  factory ListDataIbadah.fromJson(Map<String, dynamic> json) => ListDataIbadah(
        title: json['title'],
        thumbnail: json['thumbnail'],
        date: json['date'],
        time: json['time'],
      );
}
