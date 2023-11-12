// News Berita Home Response Success
class DetailBeritaResponse {
  DetailBeritaResponse({
    this.statusCode,
    this.message,
    this.beritaDetail,
  });

  int? statusCode;
  String? message;
  DetailBerita? beritaDetail;

  factory DetailBeritaResponse.fromJson(Map<String, dynamic> json) {
    return DetailBeritaResponse(
      statusCode: json["status_code"],
      message: json["message"],
      beritaDetail:
          json['data'] == null ? null : DetailBerita.fromJson(json['data']),
    );
  }
}

class DetailBerita {
  DetailBerita({
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

  factory DetailBerita.fromJson(Map<String, dynamic> json) => DetailBerita(
        id: json["id"],
        title: json['title'],
        thumbnail: json['thumbnail'],
        content: json['content'],
        slug: json['slug'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );
}
