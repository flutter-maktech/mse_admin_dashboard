import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/api_provider.dart';

class SendNotificationController extends GetxController {
  final ApiProvider apiProvider;
  
  SendNotificationController({required this.apiProvider});

  final messageController = TextEditingController();
  final isLoading = false.obs;

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  void sendNotification() async {
    final message = messageController.text.trim();
    if (message.isEmpty) {
      Get.snackbar('Error', 'Message cannot be empty', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    
    try {
      isLoading.value = true;
      await apiProvider.sendNotification(message);
      
      Get.snackbar('Success', 'Notification sent successfully', snackPosition: SnackPosition.BOTTOM);
      
      Future.delayed(const Duration(milliseconds: 1500), () {
        Get.back();
      });
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
