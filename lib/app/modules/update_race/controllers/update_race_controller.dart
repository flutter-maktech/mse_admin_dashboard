import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mse_dashboard/app/routes/app_pages.dart';
import '../../../data/models/race_model.dart';
import '../../../data/providers/api_provider.dart';
import '../../race_admin/controllers/race_admin_controller.dart';

class UpdateRaceController extends GetxController {
  final ApiProvider apiProvider;

  UpdateRaceController({required this.apiProvider});

  late RaceModel race;

  final serialNumberController = TextEditingController();
  final nameController = TextEditingController();
  final logoController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    race = Get.arguments as RaceModel;
    serialNumberController.text = race.serialNumber?.toString() ?? '';
    nameController.text = race.name ?? '';
    logoController.text = race.imageLogo ?? '';
  }

  @override
  void onClose() {
    serialNumberController.dispose();
    nameController.dispose();
    logoController.dispose();
    super.onClose();
  }

  void updateRace() async {
    if (nameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Name is required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;
      final data = {
        if (serialNumberController.text.isNotEmpty)
          'serial_number': int.tryParse(serialNumberController.text),
        'name': nameController.text,
        'image_logo': logoController.text,
      };

      await apiProvider.updateRace(race.id!, data);

      Get.snackbar(
        'Success',
        'Race updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Refresh previous list
      if (Get.isRegistered<RaceAdminController>()) {
        Get.find<RaceAdminController>().fetchRaces();
      }

      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.toNamed(Routes.raceAdmin); // Go back to dashboard
      });
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
