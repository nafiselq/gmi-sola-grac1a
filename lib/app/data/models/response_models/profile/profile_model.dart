// News Berita Home Response Success
class ProfileResponse {
  ProfileResponse({
    this.statusCode,
    this.message,
    this.dataProfile,
  });

  int? statusCode;
  String? message;
  DataProfile? dataProfile;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      statusCode: json["status_code"],
      message: json["message"],
      dataProfile: DataProfile.fromJson(json['data']),
    );
  }
}

class DataProfile {
  DataProfile({
    this.id,
    this.username,
    this.role,
    // this.photoProfile
    this.biodataProfile,
  });

  int? id;
  String? username;
  int? role;
  // String? photoProfile;
  BiodataProfile? biodataProfile;

  factory DataProfile.fromJson(Map<String, dynamic> json) => DataProfile(
        id: json["id"],
        username: json['username'],
        role: json['role'],
        // photoProfile: json['biodata']['photo'],
        biodataProfile: BiodataProfile.fromJson(json['biodata']),
      );
}

class BiodataProfile {
  BiodataProfile(
      {this.id,
      this.userId,
      this.chruchId,
      this.name,
      this.gender,
      this.placeOfBirth,
      this.dateOfBirth,
      this.blood,
      this.address,
      this.province,
      this.city,
      this.district,
      this.subDistrict,
      this.postalCode,
      this.skill,
      this.job,
      this.jobDesc,
      this.jobAddress,
      this.phone,
      this.whatsapp,
      this.email,
      this.fatherName,
      this.motherName,
      this.maritalStatus,
      this.ceremonial,
      this.children,
      this.congregationStatus,
      this.status,
      this.comission,
      this.serviceHistory,
      this.baptis,
      this.baptisChurchName,
      this.placeOfBaptis,
      this.dateOfBaptis,
      this.baptisPastorName,
      this.sidiChurchName,
      this.placeOfSidi,
      this.dateOfSidi,
      this.sidiPastorName,
      this.beforeChurchName,
      this.createdAt,
      this.updatedAt,
      this.education,
      this.telp,
      this.marriageOfDate,
      this.commisionStatus,
      this.photo,
      this.partnerName,
      this.marriageOfPlace,
      this.bloodRhesus});

  int? id;
  int? userId;
  int? chruchId;
  String? name;
  String? gender;
  String? placeOfBirth;
  String? dateOfBirth;
  String? blood;
  String? address;
  String? province;
  String? city;
  String? district;
  String? subDistrict;
  String? postalCode;
  String? skill;
  String? job;
  String? jobDesc;
  String? jobAddress;
  String? phone;
  String? whatsapp;
  String? email;
  String? fatherName;
  String? motherName;
  String? maritalStatus;
  String? marriageOfPlace;
  String? ceremonial;
  List<String>? children;
  String? congregationStatus;
  String? status;
  String? comission;
  List<ServiceHistory>? serviceHistory;
  String? baptis;
  String? baptisChurchName;
  String? placeOfBaptis;
  String? dateOfBaptis;
  String? baptisPastorName;
  String? sidiChurchName;
  String? placeOfSidi;
  String? dateOfSidi;
  String? sidiPastorName;
  String? beforeChurchName;
  String? createdAt;
  String? updatedAt;
  String? education;
  String? telp;
  String? marriageOfDate;
  String? commisionStatus;
  String? photo;
  String? partnerName;
  String? bloodRhesus;

  factory BiodataProfile.fromJson(Map<String, dynamic> json) {
    // Convert the list of children from JSON to List<String>
    List<dynamic>? childrenJson = json['children'];

    List<String> childrenList = [];
    if (childrenJson != null) {
      childrenList = childrenJson.map((item) => item.toString()).toList();
    }
    return BiodataProfile(
      id: json['id'],
      userId: json['user_id'],
      chruchId: json['church_id'],
      name: json['name'],
      gender: json['gender'],
      placeOfBirth: json['place_of_birth'],
      dateOfBirth: json['date_of_birth'],
      blood: json['blood'],
      address: json['address'],
      province: json['province'],
      city: json['city'],
      district: json['district'],
      subDistrict: json['subdistrict'],
      postalCode: json['postal_code'],
      skill: json['skill'],
      job: json['job'],
      jobDesc: json['job_description'],
      jobAddress: json['job_address'],
      phone: json['phone'],
      whatsapp: json['whatsapp'],
      email: json['email'],
      fatherName: json['father_name'],
      motherName: json['mother_name'],
      maritalStatus: json['marital_status'],
      marriageOfPlace: json['marriage_of_place'],
      ceremonial: json['ceremonial'],
      children: childrenList,
      congregationStatus: json['congregation_status'],
      status: json['status'],
      comission: json['comission'],
      serviceHistory: json['service_history'] == null
          ? null
          : List<ServiceHistory>.from(
              json["service_history"].map(
                (x) => ServiceHistory.fromJson(x),
              ),
            ),
      baptis: json['baptis'],
      baptisChurchName: json['baptis_church_name'],
      placeOfBaptis: json['place_of_baptis'],
      dateOfBaptis: json['date_of_baptis'],
      baptisPastorName: json['baptis_pastor_name'],
      sidiChurchName: json['sidi_church_name'],
      placeOfSidi: json['place_of_sidi'],
      dateOfSidi: json['date_of_sidi'],
      sidiPastorName: json['sidi_pastor_name'],
      beforeChurchName: json['before_church_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      education: json['education'],
      telp: json['telp'],
      marriageOfDate: json['marriage_of_date'],
      commisionStatus: json['comission_status'],
      photo: json['photo'],
      partnerName: json['partner_name'],
      bloodRhesus: json['blood_rhesus'],
    );
  }
}

class ServiceHistory {
  ServiceHistory({
    this.startAt,
    this.endAt,
    this.serviceSkill,
  });

  String? startAt;
  String? endAt;
  String? serviceSkill;

  factory ServiceHistory.fromJson(Map<String, dynamic> json) => ServiceHistory(
        startAt: json['start_at'],
        endAt: json['end_at'],
        serviceSkill: json['service_skill'],
      );
}
