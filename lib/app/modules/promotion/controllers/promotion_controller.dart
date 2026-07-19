import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/promotion_model.dart';
import '../../../data/providers/api_provider.dart';

class PromotionController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController urlController;

  final rxPromotions = <PromotionModel>[].obs;
  final imageBytes = Rxn<Uint8List>();
  final imageName = ''.obs;
  final isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    urlController = TextEditingController();
    fetchPromotions();
    super.onInit();
  }

  Future<void> fetchPromotions() async {
    try {
      isLoading.value = true;
      final promotions = await Get.find<ApiProvider>().getPromotions();
      rxPromotions.assignAll(promotions);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load promotions: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    urlController.clear();
    imageBytes.value = null;
    imageName.value = '';
  }

  void setFieldsForUpdate(PromotionModel promotion) {
    titleController.text = promotion.title ?? '';
    descriptionController.text = promotion.subtitle ?? '';
    urlController.text = promotion.url ?? '';
    imageBytes.value = promotion.imageBytes;
    imageName.value = '';
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

  void createPromotion() async {
    final title = titleController.text.trim();
    final descriptionText = descriptionController.text.trim();
    final url = urlController.text.trim();

    if (title.isEmpty || descriptionText.isEmpty || url.isEmpty) {
      Get.snackbar(
        'Error',
        'Title, Description, and Promotion URL are required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      final form = FormData({
        'title': title,
        'subtitle': '',
        'description': descriptionText,
        'url': url,
        if (imageBytes.value != null && imageName.value.isNotEmpty)
          'image': MultipartFile(
            imageBytes.value!,
            filename: imageName.value,
          ),
      });

      await Get.find<ApiProvider>().createPromotion(form);

      clearFields();
      Get.back();
      fetchPromotions();

      Get.snackbar(
        'Success',
        'Promotion created successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void updatePromotion(int id) async {
    final title = titleController.text.trim();
    final descriptionText = descriptionController.text.trim();
    final url = urlController.text.trim();

    if (title.isEmpty || descriptionText.isEmpty || url.isEmpty) {
      Get.snackbar(
        'Error',
        'Title, Description, and Promotion URL are required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;

      final form = FormData({
        'title': title,
        'subtitle': '',
        'description': descriptionText,
        'url': url,
        if (imageBytes.value != null && imageName.value.isNotEmpty)
          'image': MultipartFile(
            imageBytes.value!,
            filename: imageName.value,
          ),
      });

      await Get.find<ApiProvider>().updatePromotion(id, form);

      clearFields();
      Get.back();
      fetchPromotions();

      Get.snackbar(
        'Success',
        'Promotion updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void deletePromotion(int id) async {
    try {
      isLoading.value = true;
      await Get.find<ApiProvider>().deletePromotion(id);

      Get.snackbar(
        'Success',
        'Promotion deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      fetchPromotions();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    urlController.dispose();
    super.onClose();
  }
}
