import 'package:get/get.dart';
import '../../../data/models/event_model.dart';
import '../../../data/models/race_model.dart';
import '../../../data/providers/api_provider.dart';
import 'package:intl/intl.dart';

class AllEventsController extends GetxController {
  final rxEvents = <EventModel>[].obs;
  late RaceModel race;

  @override
  void onInit() {
    super.onInit();
    race = Get.arguments as RaceModel;
    rxEvents.assignAll(race.events ?? []);
  }

  void addEvent(EventModel event) {
    rxEvents.add(event);
    if (race.events == null) {
      race.events = [];
    }
    race.events!.add(event);
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

  void deleteEvent(int id) async {
    try {
      await Get.find<ApiProvider>().deleteEvent(id);
      rxEvents.removeWhere((e) => e.id == id);
      race.events?.removeWhere((e) => e.id == id);
      Get.snackbar('Success', 'Event deleted successfully', snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void updateLocalEvent(EventModel updatedEvent) {
    final index = rxEvents.indexWhere((e) => e.id == updatedEvent.id);
    if (index != -1) {
      rxEvents[index] = updatedEvent;
    }
    
    if (race.events != null) {
      final raceIndex = race.events!.indexWhere((e) => e.id == updatedEvent.id);
      if (raceIndex != -1) {
        race.events![raceIndex] = updatedEvent;
      }
    }
  }
}
