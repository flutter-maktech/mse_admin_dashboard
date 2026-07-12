import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/update_event_controller.dart';
import '../../../constants/app_colors.dart';

class UpdateEventView extends GetView<UpdateEventController> {
  const UpdateEventView({Key? key}) : super(key: key);

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
                    'Update Event',
                    style: TextStyle(fontSize: 24, color: AppColors.textBlack),
                  ),
                  IconButton(
                    icon: const Icon(Icons.grid_view, color: AppColors.textBlack),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('TV Broadcast Channel'),
                        const SizedBox(height: 8),
                        _buildTextField(controller.tvChannelController),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Radio Broadcast Channel'),
                        const SizedBox(height: 8),
                        _buildTextField(controller.radioChannelController),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Location'),
                        const SizedBox(height: 8),
                        _buildTextField(controller.locationController),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Date'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller.dateController, 
                          hintText: '00/00/0000',
                          suffixIcon: Icons.calendar_today_outlined,
                          readOnly: true,
                          onTap: () => controller.pickDate(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              SizedBox(
                width: 326, // Half width minus padding roughly to match screenshot layout
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Time'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller.timeController, 
                      hintText: '00:00',
                      suffixIcon: Icons.access_time_outlined,
                      readOnly: true,
                      onTap: () => controller.pickTime(context),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryRed,
                      foregroundColor: AppColors.rowWhite,
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                    ),
                    onPressed: controller.isLoading.value ? null : controller.updateEvent,
                    child: controller.isLoading.value
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: AppColors.rowWhite, strokeWidth: 2))
                        : const Text('Update Event'),
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
      style: TextStyle(fontSize: 14, color: AppColors.textBlack.withOpacity(0.9)),
    );
  }

  Widget _buildTextField(TextEditingController textController, {String? hintText, IconData? suffixIcon, bool readOnly = false, VoidCallback? onTap}) {
    return TextField(
      controller: textController,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.rowWhite,
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.textBlack.withOpacity(0.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: AppColors.textBlack.withOpacity(0.7)) : null,
      ),
    );
  }
}
