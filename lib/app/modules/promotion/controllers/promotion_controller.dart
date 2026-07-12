import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PromotionController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController subtitleController;
  late TextEditingController urlController;

  @override
  void onInit() {
    titleController = TextEditingController();
    subtitleController = TextEditingController();
    urlController = TextEditingController();
    super.onInit();
  }

  final imageBytes = Rxn<Uint8List>();
  final imageName = ''.obs;
  final isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

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

  void createPromotion() async {
    final title = titleController.text.trim();
    final subtitle = subtitleController.text.trim();
    final url = urlController.text.trim();

    if (title.isEmpty || subtitle.isEmpty || url.isEmpty) {
      Get.snackbar(
        'Error',
        'Title, Subtitle, and Promotion URL are required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (imageBytes.value == null) {
      Get.snackbar(
        'Error',
        'Please select an image for the promotion',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;
      // Simulate backend implementation delay
      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(
        'Success',
        'Promotion created successfully (Local Mock)',
        snackPosition: SnackPosition.BOTTOM,
      );

      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.back();
      });
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    subtitleController.dispose();
    urlController.dispose();
    super.onClose();
  }
}
