import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/update_race_controller.dart';
import '../../../constants/app_colors.dart';

class UpdateRaceView extends GetView<UpdateRaceController> {
  const UpdateRaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.rowWhite,
      body: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(32),
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
                    'Update Race',
                    style: TextStyle(fontSize: 24, color: AppColors.textBlack),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryRed,
                      foregroundColor: AppColors.rowWhite,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                    onPressed: () => Get.back(),
                    child: const Text('Dashboard'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              _buildLabel('Serial Number'),
              const SizedBox(height: 8),
              _buildTextField(controller.serialNumberController, isNumber: true),
              
              const SizedBox(height: 16),
              _buildLabel('Race Name'),
              const SizedBox(height: 8),
              _buildTextField(controller.nameController),
              
              const SizedBox(height: 16),
              _buildLabel('Paste Logo Link'),
              const SizedBox(height: 8),
              _buildTextField(controller.logoController),
              
              const SizedBox(height: 32),
              Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryRed,
                      foregroundColor: AppColors.rowWhite,
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    ),
                    onPressed: controller.isLoading.value ? null : controller.updateRace,
                    child: controller.isLoading.value
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: AppColors.rowWhite, strokeWidth: 2))
                        : const Text('Save'),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, color: AppColors.textBlack.withOpacity(0.7)),
    );
  }

  Widget _buildTextField(TextEditingController textController, {bool isNumber = false}) {
    return TextField(
      controller: textController,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.rowWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
