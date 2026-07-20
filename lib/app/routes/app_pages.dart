import 'package:get/get.dart';
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
import '../modules/race_requests/bindings/race_requests_binding.dart';
import '../modules/race_requests/views/race_requests_view.dart';
import '../modules/race_reports/bindings/race_reports_binding.dart';
import '../modules/race_reports/views/race_reports_view.dart';
import '../modules/create_race/bindings/create_race_binding.dart';
import '../modules/create_race/views/create_race_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/promotion/bindings/promotion_binding.dart';
import '../modules/promotion/views/promotion_view.dart';
import '../modules/promotion/views/create_promotion_view.dart';
import '../modules/promotion/views/update_promotion_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.login;

  static final routes = [
    GetPage(
      name: _Paths.raceAdmin,
      page: () => const RaceAdminView(),
      binding: RaceAdminBinding(),
    ),
    GetPage(
      name: _Paths.updateRace,
      page: () => const UpdateRaceView(),
      binding: UpdateRaceBinding(),
    ),
    GetPage(
      name: _Paths.allEvents,
      page: () => const AllEventsView(),
      binding: AllEventsBinding(),
    ),
    GetPage(
      name: _Paths.createEvent,
      page: () => const CreateEventView(),
      binding: CreateEventBinding(),
    ),
    GetPage(
      name: _Paths.updateEvent,
      page: () => const UpdateEventView(),
      binding: UpdateEventBinding(),
    ),
    GetPage(
      name: _Paths.sendNotification,
      page: () => const SendNotificationView(),
      binding: SendNotificationBinding(),
    ),
    GetPage(
      name: _Paths.raceRequests,
      page: () => const RaceRequestsView(),
      binding: RaceRequestsBinding(),
    ),
    GetPage(
      name: _Paths.raceReports,
      page: () => const RaceReportsView(),
      binding: RaceReportsBinding(),
    ),
    GetPage(
      name: _Paths.createRace,
      page: () => const CreateRaceView(),
      binding: CreateRaceBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.promotion,
      page: () => const PromotionView(),
      binding: PromotionBinding(),
    ),
    GetPage(
      name: _Paths.createPromotion,
      page: () => const CreatePromotionView(),
    ),
    GetPage(
      name: _Paths.updatePromotion,
      page: () => const UpdatePromotionView(),
    ),
  ];
}
