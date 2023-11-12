import 'package:get/get.dart';

import '../modules/anggota/bindings/anggota_binding.dart';
import '../modules/anggota/views/anggota_view.dart';
import '../modules/berita/bindings/berita_binding.dart';
import '../modules/berita/views/berita_view.dart';
import '../modules/detail_anggota/bindings/detail_anggota_binding.dart';
import '../modules/detail_anggota/views/detail_anggota_view.dart';
import '../modules/detail_berita/bindings/detail_berita_binding.dart';
import '../modules/detail_berita/views/detail_berita_view.dart';
import '../modules/detail_ibadah/bindings/detail_ibadah_binding.dart';
import '../modules/detail_ibadah/views/detail_ibadah_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/error_page/bindings/error_page_binding.dart';
import '../modules/error_page/views/error_page_view.dart';
import '../modules/history_presence/bindings/history_presence_binding.dart';
import '../modules/history_presence/views/history_presence_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/ibadah/bindings/ibadah_binding.dart';
import '../modules/ibadah/views/ibadah_view.dart';
import '../modules/informasi_pribadi/bindings/informasi_pribadi_binding.dart';
import '../modules/informasi_pribadi/views/informasi_pribadi_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.BERITA,
      page: () => const BeritaView(),
      binding: BeritaBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_BERITA,
      page: () => const DetailBeritaView(),
      binding: DetailBeritaBinding(),
    ),
    GetPage(
      name: _Paths.IBADAH,
      page: () => const IbadahView(),
      binding: IbadahBinding(),
    ),
    GetPage(
      name: _Paths.ANGGOTA,
      page: () => const AnggotaView(),
      binding: AnggotaBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ANGGOTA,
      page: () => const DetailAnggotaView(),
      binding: DetailAnggotaBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_IBADAH,
      page: () => const DetailIbadahView(),
      binding: DetailIbadahBinding(),
    ),
    GetPage(
      name: _Paths.ERROR_PAGE,
      page: () => const ErrorPageView(),
      binding: ErrorPageBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_PRESENCE,
      page: () => const HistoryPresenceView(),
      binding: HistoryPresenceBinding(),
    ),
    GetPage(
      name: _Paths.INFORMASI_PRIBADI,
      page: () => const InformasiPribadiView(),
      binding: InformasiPribadiBinding(),
    ),
  ];
}
