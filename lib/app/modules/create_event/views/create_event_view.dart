import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/create_event_controller.dart';
import '../../../constants/app_colors.dart';

class CreateEventView extends GetView<CreateEventController> {
  const CreateEventView({super.key});

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
                'Create an Event',
                style: TextStyle(fontSize: 24, color: AppColors.textBlack),
              ),
              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Broadcast Tv channel'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller.tvChannelController,
                          hintText: 'Write a channel name..',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Broadcast Radio channel'),
                        const SizedBox(height: 8),
                        _buildTextField(
                          controller.radioChannelController,
                          hintText: 'Write a radio channel name..',
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              _buildLabel('Location'),
              const SizedBox(height: 8),
              _buildTextField(
                controller.locationController,
                hintText: 'Location',
              ),

              const SizedBox(height: 24),
              Row(
                children: [
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
                  const SizedBox(width: 24),
                  Expanded(
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
                ],
              ),

              const SizedBox(height: 40),
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
                      : controller.createEvent,
                  child: controller.isLoading.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: AppColors.rowWhite,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Create an Event'),
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
    TextEditingController textController, {
    String? hintText,
    IconData? suffixIcon,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: textController,
      readOnly: readOnly,
      onTap: onTap,
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
        suffixIcon: suffixIcon != null
            ? Icon(
                suffixIcon,
                color: AppColors.textBlack.withValues(alpha: 0.7),
              )
            : null,
      ),
    );
  }
}
