import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/create_race_controller.dart';
import '../../../constants/app_colors.dart';

class CreateRaceView extends GetView<CreateRaceController> {
  const CreateRaceView({super.key});

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
              const Text(
                'Create a Race',
                style: TextStyle(fontSize: 24, color: AppColors.textBlack),
              ),
              const SizedBox(height: 32),

              _buildLabel('Serial Number'),
              const SizedBox(height: 8),
              _buildTextField(
                controller.serialNumberController,
                'Enter serial number..',
              ),

              const SizedBox(height: 24),

              _buildLabel('Race Name'),
              const SizedBox(height: 8),
              _buildTextField(
                controller.raceNameController,
                'write a Race name..',
              ),

              const SizedBox(height: 24),

              _buildLabel('Select Logo Image'),
              const SizedBox(height: 8),
              Obx(() {
                final bytes = controller.imageBytes.value;
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

              const SizedBox(height: 40),
              Obx(
                () => SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryRed,
                      foregroundColor: AppColors.rowWhite,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.createRace,
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: AppColors.rowWhite,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Create', style: TextStyle(fontSize: 16)),
                  ),
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
        color: AppColors.textBlack.withValues(alpha: 0.9),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController textController,
    String hintText,
  ) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.rowWhite,
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.textBlack.withValues(alpha: 0.5)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
