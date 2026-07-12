import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/race_admin/bindings/race_admin_binding.dart';
import '../modules/race_admin/views/race_admin_view.dart';
import '../modules/update_race/bindings/update_race_binding.dart';
import '../modules/update_race/views/update_race_view.dart';
import '../modules/all_events/bindings/all_events_binding.dart';
import '../modules/all_events/views/all_events_view.dart';
import '../modules/create_event/bindings/create_event_binding.dart';
import '../modules/create_event/views/create_event_view.dart';
import '../modules/update_event/bindings/update_event_binding.dart';
import '../modules/update_event/views/update_event_view.dart';
import '../modules/send_notification/bindings/send_notification_binding.dart';
import '../modules/send_notification/views/send_notification_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

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
    GetPage(
      name: _Paths.CREATE_EVENT,
      page: () => const CreateEventView(),
      binding: CreateEventBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_EVENT,
      page: () => const UpdateEventView(),
      binding: UpdateEventBinding(),
    ),
    GetPage(
      name: _Paths.SEND_NOTIFICATION,
      page: () => const SendNotificationView(),
      binding: SendNotificationBinding(),
    ),
  ];
}
