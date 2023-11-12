class FormPresenceModel {
  final String? lat;
  final String? long;
  final String? scheduleId;

  FormPresenceModel({
    this.lat,
    this.long,
    this.scheduleId,
  });

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
      'schedule_id': scheduleId,
    };
  }

  factory FormPresenceModel.fromJson(Map<String, dynamic> json) =>
      FormPresenceModel(
          lat: json['lat'],
          long: json['long'],
          scheduleId: json['schedule_id']);
}
