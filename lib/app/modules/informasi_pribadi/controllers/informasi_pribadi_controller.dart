import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmi_sola_gracia_apps/app/data/models/response_models/profile/profile_model.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/fullscreen_dialog_loader.dart';
import 'package:gmi_sola_gracia_apps/app/modules/utils/global_helper.dart';

import '../../../routes/app_pages.dart';
import '../../utils/adaptive_text.dart';
import '../../utils/config_dio.dart';
import '../../utils/theme.dart';

class InformasiPribadiController extends GetxController {
  //TODO: Implement InformasiPribadiController

  Dio dio = ApiServices().launch();
  ApiServices api = ApiServices();

  final count = 0.obs;
  String textHeader = 'Informasi Data Pribadi';
  Rx<DataProfile> dataProfile = DataProfile().obs;
  RxList<String> valueAnak = <String>[].obs;
  RxList<ServiceHistory> valueServiceHistory = <ServiceHistory>[].obs;
  List<ServiceHistory> serviceHistoryList = [];
  DateTime? selectedDateBirth;
  RxBool isLoading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> listDropdownGender = [
    {
      'nameGender': 'Laki-Laki',
    },
    {
      'nameGender': 'Perempuan',
    },
  ];

  List<Map<String, dynamic>> listDropdownBlood = [
    {
      'blood': 'A',
    },
    {
      'blood': 'B',
    },
    {
      'blood': 'AB',
    },
    {
      'blood': 'O',
    },
  ];

  List<Map<String, dynamic>> listDropdownBloodRhesus = [
    {
      'bloodRhesus': 'Tidak Tahu',
    },
    {
      'bloodRhesus': '+',
    },
    {
      'bloodRhesus': '-',
    },
  ];

  List<Map<String, dynamic>> listDropdownEducation = [
    {
      'education': 'Tidak Sekolah',
    },
    {
      'education': 'SD',
    },
    {
      'education': 'SMP',
    },
    {
      'education': 'SMA',
    },
    {
      'education': 'D1',
    },
    {
      'education': 'D2',
    },
    {
      'education': 'D3',
    },
    {
      'education': 'D4',
    },
    {
      'education': 'S1',
    },
    {
      'education': 'S2',
    },
    {
      'education': 'S3',
    },
  ];

  List<Map<String, dynamic>> listDropdownStatusJemaat = [
    {
      'statusJemaat': 'Persiapan',
    },
    {
      'statusJemaat': 'Penuh',
    },
    {
      'statusJemaat': 'Rangkap',
    },
    {
      'statusJemaat': 'Simpatisan',
    },
  ];

  List<Map<String, dynamic>> listDropdownStatusAktifJemaat = [
    {
      'statusAktifJemaat': 'Aktif',
    },
    {
      'statusAktifJemaat': 'Tidak Aktif',
    },
    {
      'statusAktifJemaat': 'Keluar',
    },
    {
      'statusAktifJemaat': 'Meninggal Dunia',
    },
  ];

  List<Map<String, dynamic>> listDropdownJoinCommission = [
    {
      'joinCommission': 'Sekolah Minggu',
    },
    {
      'joinCommission': 'PRMI',
    },
    {
      'joinCommission': 'P3MI',
    },
    {
      'joinCommission': 'PWMI',
    },
    {
      'joinCommission': 'P2MI',
    },
  ];

  List<Map<String, dynamic>> listDropdownStatusCommission = [
    {
      'statusCommission': 'Aktif',
    },
    {
      'statusCommission': 'Tidak Aktif',
    },
    {
      'statusCommission': 'Keluar',
    },
    {
      'statusCommission': 'Meninggal Dunia',
    },
  ];

  List<Map<String, dynamic>> listDropdownStatusBaptis = [
    {
      'statusBaptis': 'Anak',
    },
    {
      'statusBaptis': 'Dewasa',
    },
  ];

  TextEditingController nameC = TextEditingController();
  TextEditingController genderC = TextEditingController();
  TextEditingController placeOfBirthC = TextEditingController();
  TextEditingController dateOfBirthC = TextEditingController();
  TextEditingController bloodC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController provinceC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController districtC = TextEditingController();
  TextEditingController subdistrictC = TextEditingController();
  TextEditingController postalCodeC = TextEditingController();
  TextEditingController skillC = TextEditingController();
  TextEditingController jobC = TextEditingController();
  TextEditingController jobDescC = TextEditingController();
  TextEditingController jobAddressC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController whatsappC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController fatherNameC = TextEditingController();
  TextEditingController motherNameC = TextEditingController();
  TextEditingController maritalStatusC = TextEditingController();
  TextEditingController marriageOfPlaceC = TextEditingController();
  TextEditingController ceremonialC = TextEditingController();
  //children
  List<TextEditingController> childrenC =
      List.generate(9999, (index) => TextEditingController());
  // end children
  TextEditingController congregationStatusC = TextEditingController();
  TextEditingController statusC = TextEditingController();
  TextEditingController comissionC = TextEditingController();
  // List<TextEditingController> serviceHistoryC =
  //     List.generate(9999, (index) => TextEditingController());
  List<TextEditingController> waktuAwalC =
      List.generate(9999, (index) => TextEditingController());
  List<TextEditingController> waktuAkhirC =
      List.generate(9999, (index) => TextEditingController());
  List<TextEditingController> bidangPelayananC =
      List.generate(9999, (index) => TextEditingController());
  TextEditingController baptisC = TextEditingController();
  TextEditingController baptisChurchNameC = TextEditingController();
  TextEditingController placeOfBaptisC = TextEditingController();
  TextEditingController dateOfBaptisC = TextEditingController();
  TextEditingController baptisPastorNameC = TextEditingController();
  TextEditingController sidiChurchNameC = TextEditingController();
  TextEditingController placeOfSidiC = TextEditingController();
  TextEditingController dateOfSidiC = TextEditingController();
  TextEditingController sidiPastorNameC = TextEditingController();
  TextEditingController beforeChurchNameC = TextEditingController();
  TextEditingController educationC = TextEditingController();
  TextEditingController telpC = TextEditingController();
  TextEditingController marriageOfDateC = TextEditingController();
  TextEditingController comissionStatusC = TextEditingController();
  TextEditingController parnerNameC = TextEditingController();
  TextEditingController bloodRhesusC = TextEditingController();

  initTextController() {
    if (dataProfile.value.biodataProfile?.name != null) {
      nameC.text = dataProfile.value.biodataProfile!.name.toString();
    }
    if (dataProfile.value.biodataProfile?.gender != null) {
      genderC.text = dataProfile.value.biodataProfile!.gender.toString();
    }
    if (dataProfile.value.biodataProfile?.placeOfBirth != null) {
      placeOfBirthC.text =
          dataProfile.value.biodataProfile!.placeOfBirth.toString();
    }
    if (dataProfile.value.biodataProfile?.dateOfBirth != null) {
      dateOfBirthC.text = GlobalHelper().formatDateFromJson(
          dataProfile.value.biodataProfile!.dateOfBirth.toString());
    }
    if (dataProfile.value.biodataProfile?.blood != null) {
      bloodC.text = dataProfile.value.biodataProfile!.blood.toString();
    }
    if (dataProfile.value.biodataProfile?.address != null) {
      addressC.text = dataProfile.value.biodataProfile!.address.toString();
    }
    if (dataProfile.value.biodataProfile?.province != null) {
      provinceC.text = dataProfile.value.biodataProfile!.province.toString();
    }
    if (dataProfile.value.biodataProfile?.city != null) {
      cityC.text = dataProfile.value.biodataProfile!.city.toString();
    }
    if (dataProfile.value.biodataProfile?.district != null) {
      districtC.text = dataProfile.value.biodataProfile!.district.toString();
    }
    if (dataProfile.value.biodataProfile?.subDistrict != null) {
      subdistrictC.text =
          dataProfile.value.biodataProfile!.subDistrict.toString();
    }
    if (dataProfile.value.biodataProfile?.postalCode != null) {
      postalCodeC.text =
          dataProfile.value.biodataProfile!.postalCode.toString();
    }
    if (dataProfile.value.biodataProfile?.skill != null) {
      skillC.text = dataProfile.value.biodataProfile!.skill.toString();
    }
    if (dataProfile.value.biodataProfile?.job != null) {
      jobC.text = dataProfile.value.biodataProfile!.job.toString();
    }
    if (dataProfile.value.biodataProfile?.jobDesc != null) {
      jobDescC.text = dataProfile.value.biodataProfile!.jobDesc.toString();
    }
    if (dataProfile.value.biodataProfile?.jobAddress != null) {
      jobAddressC.text =
          dataProfile.value.biodataProfile!.jobAddress.toString();
    }
    if (dataProfile.value.biodataProfile?.phone != null) {
      phoneC.text = dataProfile.value.biodataProfile!.phone.toString();
    }
    if (dataProfile.value.biodataProfile?.whatsapp != null) {
      whatsappC.text = dataProfile.value.biodataProfile!.whatsapp.toString();
    }
    if (dataProfile.value.biodataProfile?.email != null) {
      emailC.text = dataProfile.value.biodataProfile!.email.toString();
    }
    if (dataProfile.value.biodataProfile?.fatherName != null) {
      fatherNameC.text =
          dataProfile.value.biodataProfile!.fatherName.toString();
    }
    if (dataProfile.value.biodataProfile?.motherName != null) {
      motherNameC.text =
          dataProfile.value.biodataProfile!.motherName.toString();
    }
    if (dataProfile.value.biodataProfile?.maritalStatus != null) {
      maritalStatusC.text =
          dataProfile.value.biodataProfile!.maritalStatus.toString();
    }
    if (dataProfile.value.biodataProfile?.marriageOfPlace != null) {
      marriageOfPlaceC.text =
          dataProfile.value.biodataProfile!.marriageOfPlace.toString();
    }
    if (dataProfile.value.biodataProfile?.ceremonial != null) {
      ceremonialC.text =
          dataProfile.value.biodataProfile!.ceremonial.toString();
    }
    if (dataProfile.value.biodataProfile?.serviceHistory != null) {
      for (int i = 0;
          i < dataProfile.value.biodataProfile!.serviceHistory!.length;
          i++) {
        valueServiceHistory
            .add(dataProfile.value.biodataProfile!.serviceHistory![i]);
        waktuAwalC[i].text = GlobalHelper()
            .formatDateFromJson(valueServiceHistory[i].startAt.toString());
        waktuAkhirC[i].text = GlobalHelper()
            .formatDateFromJson(valueServiceHistory[i].endAt.toString());
        bidangPelayananC[i].text =
            valueServiceHistory[i].serviceSkill.toString();
      }
    }
    if (dataProfile.value.biodataProfile?.congregationStatus != null) {
      congregationStatusC.text =
          dataProfile.value.biodataProfile!.congregationStatus.toString();
    }
    if (dataProfile.value.biodataProfile?.status != null) {
      statusC.text = dataProfile.value.biodataProfile!.status.toString();
    }
    if (dataProfile.value.biodataProfile?.comission != null) {
      comissionC.text = dataProfile.value.biodataProfile!.comission.toString();
    }
    if (dataProfile.value.biodataProfile?.children != null) {
      for (int i = 0;
          i < dataProfile.value.biodataProfile!.children!.length;
          i++) {
        valueAnak.add(dataProfile.value.biodataProfile!.children![i]);
      }
      for (int j = 0; j < valueAnak.length; j++) {
        childrenC[j].text = valueAnak[j];
      }
    }
    if (dataProfile.value.biodataProfile?.baptis != null) {
      baptisC.text = dataProfile.value.biodataProfile!.baptis.toString();
    }
    if (dataProfile.value.biodataProfile?.baptisChurchName != null) {
      baptisChurchNameC.text =
          dataProfile.value.biodataProfile!.baptisChurchName.toString();
    }
    if (dataProfile.value.biodataProfile?.placeOfBaptis != null) {
      placeOfBaptisC.text =
          dataProfile.value.biodataProfile!.placeOfBaptis.toString();
    }
    if (dataProfile.value.biodataProfile?.dateOfBaptis != null) {
      dateOfBaptisC.text = GlobalHelper().formatDateFromJson(
          dataProfile.value.biodataProfile!.dateOfBaptis.toString());
    }
    if (dataProfile.value.biodataProfile?.baptisPastorName != null) {
      baptisPastorNameC.text =
          dataProfile.value.biodataProfile!.baptisPastorName.toString();
    }
    if (dataProfile.value.biodataProfile?.sidiChurchName != null) {
      sidiChurchNameC.text =
          dataProfile.value.biodataProfile!.sidiChurchName.toString();
    }
    if (dataProfile.value.biodataProfile?.placeOfSidi != null) {
      placeOfSidiC.text =
          dataProfile.value.biodataProfile!.placeOfSidi.toString();
    }
    if (dataProfile.value.biodataProfile?.dateOfSidi != null) {
      dateOfSidiC.text = GlobalHelper().formatDateFromJson(
          dataProfile.value.biodataProfile!.dateOfSidi.toString());
    }
    if (dataProfile.value.biodataProfile?.sidiPastorName != null) {
      sidiPastorNameC.text =
          dataProfile.value.biodataProfile!.sidiPastorName.toString();
    }
    if (dataProfile.value.biodataProfile?.beforeChurchName != null) {
      beforeChurchNameC.text =
          dataProfile.value.biodataProfile!.beforeChurchName.toString();
    }
    if (dataProfile.value.biodataProfile?.education != null) {
      educationC.text = dataProfile.value.biodataProfile!.education.toString();
    }
    if (dataProfile.value.biodataProfile?.telp != null) {
      telpC.text = dataProfile.value.biodataProfile!.telp.toString();
    }
    if (dataProfile.value.biodataProfile?.marriageOfDate != null) {
      marriageOfDateC.text = GlobalHelper().formatDateFromJson(
          dataProfile.value.biodataProfile!.marriageOfDate.toString());
    }
    if (dataProfile.value.biodataProfile?.commisionStatus != null) {
      comissionStatusC.text =
          dataProfile.value.biodataProfile!.commisionStatus.toString();
    }
    if (dataProfile.value.biodataProfile?.partnerName != null) {
      parnerNameC.text =
          dataProfile.value.biodataProfile!.partnerName.toString();
    }
    if (dataProfile.value.biodataProfile?.bloodRhesus != null) {
      bloodRhesusC.text =
          dataProfile.value.biodataProfile!.bloodRhesus.toString();
    }
  }

  void updateBiodata() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    var anak = [];
    var waktuMulai = [];
    var waktuAkhir = [];
    var bidangPelayanan = [];

    if (childrenC.isNotEmpty) {
      for (TextEditingController item in childrenC) {
        String value = item.text;
        if (value.isNotEmpty) anak.add(value);
      }
    } else {
      anak = [];
    }

    if (waktuAwalC.isNotEmpty) {
      for (TextEditingController itemAwal in waktuAwalC) {
        String value = itemAwal.text;
        if (value.isNotEmpty)
          waktuMulai.add(GlobalHelper().convertDateString(value));
      }
    } else {
      waktuMulai = [];
    }

    if (waktuAkhirC.isNotEmpty) {
      for (TextEditingController itemAkhir in waktuAkhirC) {
        String value = itemAkhir.text;
        if (value.isNotEmpty)
          waktuAkhir.add(GlobalHelper().convertDateString(value));
      }
    } else {
      waktuAkhirC = [];
    }

    if (bidangPelayananC.isNotEmpty) {
      for (TextEditingController pelayanan in bidangPelayananC) {
        String value = pelayanan.text;
        if (value.isNotEmpty) bidangPelayanan.add(value);
      }
    } else {
      bidangPelayananC = [];
    }

    var data = {
      "_method": "PUT",
      "name": nameC.text,
      "gender": genderC.text,
      "place_of_birth": placeOfBirthC.text,
      "date_of_birth": dateOfBirthC.text == ''
          ? ''
          : GlobalHelper().convertDateString(dateOfBirthC.text),
      "blood": bloodC.text,
      "blood_rhesus": bloodRhesusC.text,
      "address": addressC.text,
      "province": provinceC.text,
      "city": cityC.text,
      "district": districtC.text,
      "subdistrict": subdistrictC.text,
      "postal_code": postalCodeC.text,
      "skill": skillC.text,
      "job": jobC.text,
      "job_description": jobDescC.text,
      "job_address": jobAddressC.text,
      "phone": phoneC.text,
      "whatsapp": whatsappC.text,
      "email": emailC.text,
      "father_name": fatherNameC.text,
      "mother_name": motherNameC.text,
      "marital_status": maritalStatusC.text,
      "marriage_of_place": marriageOfPlaceC.text,
      "ceremonial": ceremonialC.text,
      "children": anak,
      "congregation_status": congregationStatusC.text,
      "status": statusC.text,
      "comission": comissionC.text,
      "start_at": waktuMulai,
      "end_at": waktuAkhir,
      "service_skill": bidangPelayanan,
      "baptis": baptisC.text,
      "baptis_church_name": baptisChurchNameC.text,
      "place_of_baptis": placeOfBaptisC.text,
      "date_of_baptis": dateOfBaptisC.text == ''
          ? ''
          : GlobalHelper().convertDateString(dateOfBaptisC.text),
      "baptis_pastor_name": baptisPastorNameC.text,
      "sidi_church_name": sidiChurchNameC.text,
      "place_of_sidi": placeOfSidiC.text,
      "date_of_sidi": dateOfSidiC.text == ''
          ? ''
          : GlobalHelper().convertDateString(dateOfSidiC.text),
      "sidi_pastor_name": sidiPastorNameC.text,
      "before_church_name": beforeChurchNameC.text,
      "education": educationC.text,
      "telp": telpC.text,
      "marriage_of_date": marriageOfDateC.text == ''
          ? ''
          : GlobalHelper().convertDateString(marriageOfDateC.text),
      "comission_status": comissionStatusC.text,
      "partner_name": parnerNameC.text,
    };

    debugPrint("ini data : $data");

    try {
      FullScreenDialogLoader.showDialog();
      final response = await dio.post(
        "${api.baseUrlMainApi}/profile/biodata",
        data: data,
      );

      if (response.statusCode == 200) {
        FullScreenDialogLoader.cancelDialog();
        debugPrint("ini suksesk : ${response.data["message"]}");
        showModalAlert(Get.context!, true,
            "${response.data["message"]}\nJika data belum berubah harap refresh dihalaman homepage");
        // FullScreenDialogLoader.showDialogSuccess();
      } else {
        FullScreenDialogLoader.cancelDialog();
        debugPrint("ini error : ${response.data}");
        showModalAlert(Get.context!, false,
            "Ooops Ada Masalah\n${response.data["message"]}");
      }
    } catch (e) {
      FullScreenDialogLoader.cancelDialog();
      debugPrint("ini error : $e");
      showModalAlert(Get.context!, false,
          "Ooops Ada MasalahSerer Internal Kami\nSilahkan Coba Lagi Nanti");
      // FullScreenDialogLoader.showAlertDialog(false, e.toString());
    }
    // debugPrint("INI DATA : $data");
  }

  void showModalAlert(BuildContext context, bool isSuccess, String text) {
    showDialog(
      barrierDismissible: false,
      useSafeArea: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            isSuccess ? Get.offNamed(Routes.SPLASH_SCREEN) : Get.back();
            return true;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            // title: Text('Judul Dialog'), // Gantilah dengan judul yang sesuai
            content: SizedBox(
              height: 250,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            isSuccess
                                ? Get.offNamed(Routes.SPLASH_SCREEN)
                                : Get.back();
                          },
                          child: const Icon(Icons.close, size: 25),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                      isSuccess
                          ? 'assets/ic-success.png'
                          : 'assets/ic-failed.png',
                      width: 60),
                  const SizedBox(height: 30),
                  Text(
                    isSuccess ? 'Yeeyyy' : 'Gagal',
                    style: blackTextStyle.copyWith(
                      fontSize: AdaptiveTextSize()
                          .getAdaptiveTextSize(Get.context!, 24),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: greyTextStyle.copyWith(
                      fontSize: AdaptiveTextSize()
                          .getAdaptiveTextSize(Get.context!, 12),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //Validate

  String? validatePlaceOfBirth(String? value) {
    if (value!.isEmpty) {
      return "Tempat Lahir harus diisi";
    }
    return null;
  }

  String? validateDateOfBirth(String? value) {
    if (value!.isEmpty) {
      return "Tanggal Lahir harus diisi";
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value!.isEmpty) {
      return "Alamat harus diisi";
    }
    return null;
  }

  String? validateProvice(String? value) {
    if (value!.isEmpty) {
      return "Provinsi harus diisi";
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value!.isEmpty) {
      return "Kota harus diisi";
    }
    return null;
  }

  String? validateDistrict(String? value) {
    if (value!.isEmpty) {
      return "Kecamatan harus diisi";
    }
    return null;
  }

  String? validateSubDistrict(String? value) {
    if (value!.isEmpty) {
      return "Kelurahan harus diisi";
    }
    return null;
  }

  String? validatePostalCode(String? value) {
    if (value!.isEmpty) {
      return "Kode Pos harus diisi";
    }
    return null;
  }

  String? validateSkill(String? value) {
    if (value!.isEmpty) {
      return "Keahlian harus diisi";
    }
    return null;
  }

  String? validateJob(String? value) {
    if (value!.isEmpty) {
      return "Pekerjaan harus diisi";
    }
    return null;
  }

  String? validateJobDesc(String? value) {
    if (value!.isEmpty) {
      return "Keterangan Pekerjaan harus diisi";
    }
    return null;
  }

  String? validateJobAddress(String? value) {
    if (value!.isEmpty) {
      return "Alamat Pekerjaan harus diisi";
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value!.isEmpty) {
      return "Nomor Handphone harus diisi";
    }
    return null;
  }

  String? validateWhatsapp(String? value) {
    if (value!.isEmpty) {
      return "Whatsapp harus diisi";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Email harus diisi";
    }
    return null;
  }

  String? validateFatherName(String? value) {
    if (value!.isEmpty) {
      return "Nama Bapak/Ayah harus diisi";
    }
    return null;
  }

  String? validateMotherName(String? value) {
    if (value!.isEmpty) {
      return "Nama Ibu/Mamah harus diisi";
    }
    return null;
  }

  String? validateTelp(String? value) {
    if (value!.isEmpty) {
      return "No Telp harus diisi";
    }
    return null;
  }

  String? validateMarriageOfData(String? value) {
    if (value!.isEmpty) {
      return "Tanggal Nikah harus diisi";
    }
    return null;
  }

  String? validatePartnerName(String? value) {
    if (value!.isEmpty) {
      return "Nama Partner harus diisi";
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    initTextController();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
