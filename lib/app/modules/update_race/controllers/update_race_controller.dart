import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/race_model.dart';
import '../../../data/providers/api_provider.dart';
import '../../race_admin/controllers/race_admin_controller.dart';

class UpdateRaceController extends GetxController {
  final ApiProvider apiProvider;

  UpdateRaceController({required this.apiProvider});

  late RaceModel race;

  final serialNumberController = TextEditingController();
  final nameController = TextEditingController();
  
  final imageBytes = Rxn<Uint8List>();
  final imageName = ''.obs;
  final existingLogoUrl = ''.obs;
  final isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    race = Get.arguments as RaceModel;
    serialNumberController.text = race.serialNumber?.toString() ?? '';
    nameController.text = race.name ?? '';
    existingLogoUrl.value = race.imageLogo ?? '';
  }

  @override
  void onClose() {
    serialNumberController.dispose();
    nameController.dispose();
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

      final form = FormData({
        if (serialNumberController.text.isNotEmpty)
          'serial_number': int.tryParse(serialNumberController.text),
        'name': nameController.text,
        if (imageBytes.value != null && imageName.value.isNotEmpty)
          'image_logo': MultipartFile(
            imageBytes.value!,
            filename: imageName.value,
          ),
      });

      await apiProvider.updateRace(race.id!, form);

      // Refresh previous list
      if (Get.isRegistered<RaceAdminController>()) {
        Get.find<RaceAdminController>().fetchRaces();
      }

      Get.back();

      Get.snackbar(
        'Success',
        'Race updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
