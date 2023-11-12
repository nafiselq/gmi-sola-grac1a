// News Berita Home Response Success
class ListAnggotaResponse {
  ListAnggotaResponse({
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
  List<ListDataAnggota>? data;

  factory ListAnggotaResponse.fromJson(Map<String, dynamic> json) {
    return ListAnggotaResponse(
      statusCode: json["status_code"],
      message: json["message"],
      currentPage: json['data'] == null ? 0 : json['data']['current_page'],
      from: json['data'] == null ? 0 : json['data']['from'],
      lastPage: json['data'] == null ? 0 : json['data']['last_page'],
      total: json['data'] == null ? 0 : json['data']['total'],
      data: json['data'] == null
          ? null
          : List<ListDataAnggota>.from(
              json["data"]["data"].map(
                (x) => ListDataAnggota.fromJson(x),
              ),
            ),
    );
  }
}

class ListDataAnggota {
  ListDataAnggota({
    this.id,
    this.name,
    this.photo,
  });

  int? id;
  String? name;
  String? photo;
  factory ListDataAnggota.fromJson(Map<String, dynamic> json) =>
      ListDataAnggota(id: json['id'], name: json['name'], photo: json['photo']);
}
