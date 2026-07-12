import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/send_notification_controller.dart';
import '../../../constants/app_colors.dart';

class SendNotificationView extends GetView<SendNotificationController> {
  const SendNotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.rowWhite,
      body: Center(
        child: Container(
          width: 700,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: AppColors.rowGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Send Notification',
                    style: TextStyle(fontSize: 24, color: AppColors.textBlack),
                  ),
                  IconButton(
                    icon: const Icon(Icons.grid_view, color: AppColors.primaryRed),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              const Text(
                'Message',
                style: TextStyle(fontSize: 14, color: AppColors.textBlack),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.messageController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.rowWhite,
                  hintText: 'write a notification body..',
                  hintStyle: TextStyle(color: AppColors.textBlack.withOpacity(0.5)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              Obx(() => SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    foregroundColor: AppColors.rowWhite,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  onPressed: controller.isLoading.value ? null : controller.sendNotification,
                  child: controller.isLoading.value
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: AppColors.rowWhite, strokeWidth: 2))
                      : const Text('Send', style: TextStyle(fontSize: 16)),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
