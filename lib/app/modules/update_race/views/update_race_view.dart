import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/update_race_controller.dart';
import '../../../constants/app_colors.dart';

class UpdateRaceView extends GetView<UpdateRaceController> {
  const UpdateRaceView({super.key});

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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                    ),
                    onPressed: () => Get.back(),
                    child: const Text('Dashboard'),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              _buildLabel('Serial Number'),
              const SizedBox(height: 8),
              _buildTextField(
                controller.serialNumberController,
                isNumber: true,
              ),

              const SizedBox(height: 16),
              _buildLabel('Race Name'),
              const SizedBox(height: 8),
              _buildTextField(controller.nameController),

              const SizedBox(height: 16),
              _buildLabel('Select Logo Image'),
              const SizedBox(height: 8),
              Obx(() {
                final bytes = controller.imageBytes.value;
                final existingUrl = controller.existingLogoUrl.value;
                return GestureDetector(
                  onTap: controller.pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppColors.rowWhite,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: bytes != null
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.memory(
                                  bytes,
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    onPressed: controller.pickImage,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : existingUrl.isNotEmpty
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      existingUrl,
                                      width: double.infinity,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(Icons.broken_image),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        onPressed: controller.pickImage,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                    size: 36,
                                    color: AppColors.textBlack.withValues(
                                      alpha: 0.4,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Click to select image',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textBlack.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                  ),
                );
              }),

              const SizedBox(height: 32),
              Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    foregroundColor: AppColors.rowWhite,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.updateRace,
                  child: controller.isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.rowWhite,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: AppColors.textBlack.withValues(alpha: 0.7),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController textController, {
    bool isNumber = false,
  }) {
    return TextField(
      controller: textController,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.rowWhite,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
