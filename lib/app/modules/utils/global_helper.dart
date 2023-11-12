import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class GlobalHelper {
  String formatDateFromJson(String jsonDate) {
    // Buat DateTime dari string JSON
    DateTime dateTime = DateTime.parse(jsonDate);

    // Buat objek DateFormat untuk mengatur format tampilan tanggal
    DateFormat outputFormat = DateFormat(
        'dd MMMM y', 'id_ID'); // Ganti 'id_ID' sesuai dengan bahasa yang sesuai

    // Ubah DateTime ke format yang diinginkan
    String formattedDate = outputFormat.format(dateTime);

    return formattedDate;
  }

  String convertTimeFormat(String timeString) {
    // Buat DateTime dari string waktu dengan format "HH:mm:ss"
    DateTime dateTime = DateFormat("HH:mm:ss").parse(timeString);

    // Buat objek DateFormat untuk mengatur format tampilan waktu
    DateFormat outputFormat = DateFormat("HH:mm");

    // Ubah DateTime ke format yang diinginkan
    String formattedTime = outputFormat.format(dateTime);

    return formattedTime;
  }

  Future<XFile?> selectImage() async {
    XFile? selectImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    return selectImage;
  }

  String convertDateString(String originalDateString) {
    // Membuat objek DateTime dari string asli dengan format yang sesuai
    DateTime originalDate = DateTime.parse(parseDateString(originalDateString));

    // Mengonversi ke dalam format yang diinginkan
    String convertedDateString =
        "${originalDate.year}-${originalDate.month.toString().padLeft(2, '0')}-${originalDate.day.toString().padLeft(2, '0')}";

    return convertedDateString;
  }

  String parseDateString(String originalDateString) {
    // Pisahkan string menjadi array berisi tanggal, bulan, dan tahun
    List<String> dateParts = originalDateString.split(' ');

    // Map nama bulan ke angka bulan
    Map<String, String> monthMap = {
      'Januari': '01',
      'Februari': '02',
      'Maret': '03',
      'April': '04',
      'Mei': '05',
      'Juni': '06',
      'Juli': '07',
      'Agustus': '08',
      'September': '09',
      'Oktober': '10',
      'November': '11',
      'Desember': '12',
    };

    // Ubah ke format yang diharapkan
    String formattedDateString =
        "${dateParts[2]}-${monthMap[dateParts[1]]}-${dateParts[0].padLeft(2, '0')}";

    return formattedDateString;
  }

  List<TextEditingController> removeDuplicates(
      List<TextEditingController> inputList) {
    // Buat Set dari List untuk menghilangkan duplikat
    Set<TextEditingController> uniqueSet =
        Set<TextEditingController>.from(inputList);

    // Konversi Set kembali ke List
    List<TextEditingController> uniqueList = uniqueSet.toList();

    return uniqueList;
  }
}
