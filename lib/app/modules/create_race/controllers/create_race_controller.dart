import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mse_dashboard/app/routes/app_pages.dart';
import '../../../data/providers/api_provider.dart';
import '../../race_admin/controllers/race_admin_controller.dart';

class CreateRaceController extends GetxController {
  final ApiProvider apiProvider;
  
  CreateRaceController({required this.apiProvider});

  final serialNumberController = TextEditingController();
  final raceNameController = TextEditingController();
  final logoLinkController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onClose() {
    serialNumberController.dispose();
    raceNameController.dispose();
    logoLinkController.dispose();
    super.onClose();
  }

  void createRace() async {
    final serialNumber = serialNumberController.text.trim();
    final name = raceNameController.text.trim();
    final logoLink = logoLinkController.text.trim();

    if (serialNumber.isEmpty || name.isEmpty || logoLink.isEmpty) {
      Get.snackbar('Error', 'All fields are required', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final serialInt = int.tryParse(serialNumber);
    if (serialInt == null) {
      Get.snackbar('Error', 'Serial Number must be an integer', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    
    try {
      isLoading.value = true;
      final data = {
        'serial_number': serialInt,
        'name': name,
        'image_logo': logoLink,
      };
      
      final newRace = await apiProvider.createRace(data);
      
      Get.snackbar('Success', 'Race created successfully', snackPosition: SnackPosition.BOTTOM);
      
      // Update RaceAdminController if it's active
      if (Get.isRegistered<RaceAdminController>()) {
        Get.find<RaceAdminController>().fetchRaces();
      }
      
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.toNamed(Routes.RACE_ADMIN);
      });
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
