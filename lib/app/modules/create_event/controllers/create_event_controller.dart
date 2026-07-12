import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/providers/api_provider.dart';
import '../../all_events/controllers/all_events_controller.dart';

class CreateEventController extends GetxController {
  final ApiProvider apiProvider;

  CreateEventController({required this.apiProvider});

  late int raceId;

  final tvChannelController = TextEditingController();
  final radioChannelController = TextEditingController();
  final locationController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    raceId = Get.arguments as int;
  }

  @override
  void onClose() {
    tvChannelController.dispose();
    radioChannelController.dispose();
    locationController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.onClose();
  }

  TimeOfDay? selectedTime;

  void pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  void pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      selectedTime = pickedTime;
      if (context.mounted) {
        timeController.text = pickedTime.format(context);
      }
    }
  }

  void createEvent() async {
    if (locationController.text.isEmpty ||
        dateController.text.isEmpty ||
        timeController.text.isEmpty ||
        selectedTime == null) {
      Get.snackbar(
        'Error',
        'Location, Date, and Time are required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Parse date and time into ISO 8601
      final datePart = DateFormat('dd/MM/yyyy').parse(dateController.text);
      final dateTime = DateTime(
        datePart.year,
        datePart.month,
        datePart.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      final data = {
        'race_id': raceId,
        'tv_broadcast_chanel': tvChannelController.text,
        'radio_broadcast_chanel': radioChannelController.text,
        'location': locationController.text,
        'started_at': dateTime.toUtc().toIso8601String(),
      };

      final createdEvent = await apiProvider.createEvent(data);

      Get.snackbar(
        'Success',
        'Event created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Add the new event to the list dynamically
      if (Get.isRegistered<AllEventsController>()) {
        Get.find<AllEventsController>().addEvent(createdEvent);
      }

      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.back(); // Go back to All Events
      });
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
