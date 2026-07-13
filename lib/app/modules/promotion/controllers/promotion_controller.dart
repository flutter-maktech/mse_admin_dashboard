import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/promotion_model.dart';

class PromotionController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController subtitleController;
  late TextEditingController urlController;

  final rxPromotions = <PromotionModel>[].obs;
  final imageBytes = Rxn<Uint8List>();
  final imageName = ''.obs;
  final isLoading = false.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    titleController = TextEditingController();
    subtitleController = TextEditingController();
    urlController = TextEditingController();
    _loadDummyPromotions();
    super.onInit();
  }

  void _loadDummyPromotions() {
    rxPromotions.addAll([
      PromotionModel(
        id: 1,
        title: 'Formula 1 Grand Prix Deal',
        subtitle:
            'Get 20% off on all early bird tickets for the next Grand Prix series.',
        url: 'https://motorsporteasy.com/f1-deal',
        imageUrl:
            'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?w=500&auto=format&fit=crop&q=60',
      ),
      PromotionModel(
        id: 2,
        title: 'Offroad Championship Pass',
        subtitle:
            'Exclusive weekend passes with paddock access. Limited availability.',
        url: 'https://motorsporteasy.com/offroad-pass',
        imageUrl:
            'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=500&auto=format&fit=crop&q=60',
      ),
      PromotionModel(
        id: 3,
        title: 'Karting League Registration',
        subtitle:
            'Sign up for the summer amateur karting league. Winners get cash prizes!',
        url: 'https://motorsporteasy.com/karting-signup',
        imageUrl:
            'https://images.unsplash.com/photo-1562591176-a117072489f6?w=500&auto=format&fit=crop&q=60',
      ),
    ]);
  }

  void clearFields() {
    titleController.clear();
    subtitleController.clear();
    urlController.clear();
    imageBytes.value = null;
    imageName.value = '';
  }

  void setFieldsForUpdate(PromotionModel promotion) {
    titleController.text = promotion.title ?? '';
    subtitleController.text = promotion.subtitle ?? '';
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

    try {
      isLoading.value = true;
      // Simulate backend implementation delay
      await Future.delayed(const Duration(milliseconds: 500));

      final newId = rxPromotions.isEmpty
          ? 1
          : (rxPromotions
                    .map((e) => e.id ?? 0)
                    .reduce((a, b) => a > b ? a : b) +
                1);
      final newPromo = PromotionModel(
        id: newId,
        title: title,
        subtitle: subtitle,
        url: url,
        imageBytes: imageBytes.value,
      );
      rxPromotions.add(newPromo);

      Get.snackbar(
        'Success',
        'Promotion created successfully (Local Mock)',
        snackPosition: SnackPosition.BOTTOM,
      );

      clearFields();

      Future.delayed(const Duration(milliseconds: 500), () {
        Get.back();
      });
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void updatePromotion(int id) async {
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

    try {
      isLoading.value = true;
      // Simulate backend implementation delay
      await Future.delayed(const Duration(milliseconds: 500));

      final index = rxPromotions.indexWhere((p) => p.id == id);
      if (index != -1) {
        final existingPromo = rxPromotions[index];
        rxPromotions[index] = PromotionModel(
          id: id,
          title: title,
          subtitle: subtitle,
          url: url,
          imageUrl: imageBytes.value == null ? existingPromo.imageUrl : null,
          imageBytes: imageBytes.value,
        );
        rxPromotions.refresh();

        Get.snackbar(
          'Success',
          'Promotion updated successfully (Local Mock)',
          snackPosition: SnackPosition.BOTTOM,
        );

        clearFields();

        Future.delayed(const Duration(milliseconds: 500), () {
          Get.back();
        });
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void deletePromotion(int id) {
    rxPromotions.removeWhere((p) => p.id == id);
    Get.snackbar(
      'Success',
      'Promotion deleted successfully (Local Mock)',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    subtitleController.dispose();
    urlController.dispose();
    super.onClose();
  }
}
