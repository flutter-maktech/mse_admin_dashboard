import 'package:get/get.dart';
import '../../../data/models/event_model.dart';
import 'package:intl/intl.dart';

class AllEventsController extends GetxController {
  final rxEvents = <EventModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final events = Get.arguments as List<EventModel>? ?? [];
    rxEvents.assignAll(events);
  }

  String formatTime(String? isoString) {
    if (isoString == null || isoString.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(isoString);
      return DateFormat('hh:mm a').format(date);
    } catch (e) {
      return 'Invalid Time';
    }
  }

  String formatDate(String? isoString) {
    if (isoString == null || isoString.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(isoString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
