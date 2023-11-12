// News Berita Home Response Success
class ListHistoryPresenceResponse {
  ListHistoryPresenceResponse({
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
  List<ListHistoryPresence>? data;

  factory ListHistoryPresenceResponse.fromJson(Map<String, dynamic> json) {
    return ListHistoryPresenceResponse(
      statusCode: json["status_code"],
      message: json["message"],
      currentPage: json['data'] == null ? 0 : json['data']['current_page'],
      from: json['data'] == null ? 0 : json['data']['from'],
      lastPage: json['data'] == null ? 0 : json['data']['last_page'],
      total: json['data'] == null ? 0 : json['data']['total'],
      data: json['data'] == null
          ? null
          : List<ListHistoryPresence>.from(
              json["data"]["data"].map(
                (x) => ListHistoryPresence.fromJson(x),
              ),
            ),
    );
  }
}

class ListHistoryPresence {
  ListHistoryPresence({this.id, this.title, this.presence});

  int? id;
  String? title;
  String? presence;
  factory ListHistoryPresence.fromJson(Map<String, dynamic> json) =>
      ListHistoryPresence(
          id: json['id'], title: json['title'], presence: json['presence']);
}
