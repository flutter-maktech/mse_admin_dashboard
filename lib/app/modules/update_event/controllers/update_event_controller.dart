import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/models/event_model.dart';
import '../../../data/providers/api_provider.dart';
import '../../all_events/controllers/all_events_controller.dart';

class UpdateEventController extends GetxController {
  final ApiProvider apiProvider;

  UpdateEventController({required this.apiProvider});

  late EventModel event;

  final tvChannelController = TextEditingController();
  final radioChannelController = TextEditingController();
  final locationController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  final isLoading = false.obs;
  TimeOfDay? selectedTime;

  @override
  void onInit() {
    super.onInit();
    event = Get.arguments as EventModel;

    tvChannelController.text = event.tvBroadcastChanel ?? '';
    radioChannelController.text = event.radioBroadcastChanel ?? '';
    locationController.text = event.location ?? '';

    if (event.startedAt != null && event.startedAt!.isNotEmpty) {
      try {
        final parsedDate = DateTime.parse(event.startedAt!).toLocal();
        dateController.text = DateFormat('dd/MM/yyyy').format(parsedDate);
        selectedTime = TimeOfDay(
          hour: parsedDate.hour,
          minute: parsedDate.minute,
        );
        // Getting context for formatting is tricky here, so we format manually or let view handle it.
        // We will format to a generic AM/PM string initially.
        timeController.text = DateFormat('hh:mm a').format(parsedDate);
      } catch (e) {
        // Ignore parsing errors for prefill
      }
    }
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
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      selectedTime = pickedTime;
      if (context.mounted) {
        timeController.text = pickedTime.format(context);
      }
    }
  }

  void updateEvent() async {
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
        'race_id': event.raceId,
        'tv_broadcast_chanel': tvChannelController.text,
        'radio_broadcast_chanel': radioChannelController.text,
        'location': locationController.text,
        'started_at': dateTime.toUtc().toIso8601String(),
      };

      final updatedEvent = await apiProvider.updateEvent(event.id!, data);

      Get.snackbar(
        'Success',
        'Event updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      if (Get.isRegistered<AllEventsController>()) {
        Get.find<AllEventsController>().updateLocalEvent(updatedEvent);
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
