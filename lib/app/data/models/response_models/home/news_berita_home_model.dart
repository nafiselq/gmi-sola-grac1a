// News Berita Home Response Success
class NewsBeritaHomeResponse {
  NewsBeritaHomeResponse({
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
  List<DataBerita>? data;

  factory NewsBeritaHomeResponse.fromJson(Map<String, dynamic> json) {
    return NewsBeritaHomeResponse(
      statusCode: json["status_code"],
      message: json["message"],
      currentPage: json['data'] == null ? 0 : json['data']['current_page'],
      from: json['data'] == null ? 0 : json['data']['from'],
      lastPage: json['data'] == null ? 0 : json['data']['last_page'],
      total: json['data'] == null ? 0 : json['data']['total'],
      data: json['data'] == null
          ? null
          : List<DataBerita>.from(
              json["data"]["data"].map(
                (x) => DataBerita.fromJson(x),
              ),
            ),
    );
  }
}

class DataBerita {
  DataBerita({
    this.id,
    this.title,
    this.thumbnail,
    this.content,
    this.slug,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? thumbnail;
  String? content;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DataBerita.fromJson(Map<String, dynamic> json) => DataBerita(
        id: json["id"],
        title: json['title'],
        thumbnail: json['thumbnail'],
        content: json['content'],
        slug: json['slug'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );
}
