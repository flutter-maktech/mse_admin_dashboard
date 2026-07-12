import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/race_admin/bindings/race_admin_binding.dart';
import '../modules/race_admin/views/race_admin_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.RACE_ADMIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.RACE_ADMIN,
      page: () => const RaceAdminView(),
      binding: RaceAdminBinding(),
    ),
  ];
}
