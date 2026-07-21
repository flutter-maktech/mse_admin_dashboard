import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/providers/api_provider.dart';
import '../../race_admin/controllers/race_admin_controller.dart';

class CreateRaceController extends GetxController {
  final ApiProvider apiProvider;

  CreateRaceController({required this.apiProvider});

  final serialNumberController = TextEditingController();
  final raceNameController = TextEditingController();
  
  final imageBytes = Rxn<Uint8List>();
  final imageName = ''.obs;
  final isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onClose() {
    serialNumberController.dispose();
    raceNameController.dispose();
    super.onClose();
  }

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        imageBytes.value = bytes;
        imageName.value = pickedFile.name;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void createRace() async {
    final serialNumber = serialNumberController.text.trim();
    final name = raceNameController.text.trim();

    if (serialNumber.isEmpty || name.isEmpty) {
      Get.snackbar(
        'Error',
        'Serial Number and Race Name are required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (imageBytes.value == null || imageName.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a logo image',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final serialInt = int.tryParse(serialNumber);
    if (serialInt == null) {
      Get.snackbar(
        'Error',
        'Serial Number must be an integer',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;
      
      final form = FormData({
        'serial_number': serialInt,
        'name': name,
        'image_logo': MultipartFile(
          imageBytes.value!,
          filename: imageName.value,
        ),
      });

      await apiProvider.createRace(form);

      // Update RaceAdminController if it's active
      if (Get.isRegistered<RaceAdminController>()) {
        Get.find<RaceAdminController>().fetchRaces();
      }

      Get.back();

      Get.snackbar(
        'Success',
        'Race created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
