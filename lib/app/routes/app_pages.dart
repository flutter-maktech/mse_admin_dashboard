import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/race_admin/bindings/race_admin_binding.dart';
import '../modules/race_admin/views/race_admin_view.dart';
import '../modules/update_race/bindings/update_race_binding.dart';
import '../modules/update_race/views/update_race_view.dart';
import '../modules/all_events/bindings/all_events_binding.dart';
import '../modules/all_events/views/all_events_view.dart';

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
    GetPage(
      name: _Paths.UPDATE_RACE,
      page: () => const UpdateRaceView(),
      binding: UpdateRaceBinding(),
    ),
    GetPage(
      name: _Paths.ALL_EVENTS,
      page: () => const AllEventsView(),
      binding: AllEventsBinding(),
    ),
  ];
}
