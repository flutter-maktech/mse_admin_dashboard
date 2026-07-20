import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/create_promotion_controller.dart';
import '../../../constants/app_colors.dart';

class CreatePromotionView extends StatefulWidget {
  const CreatePromotionView({super.key});

  @override
  State<CreatePromotionView> createState() => _CreatePromotionViewState();
}

class _CreatePromotionViewState extends State<CreatePromotionView> {
  late final CreatePromotionController controller;

  @override
  void initState() {
    controller = Get.put(CreatePromotionController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<CreatePromotionController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.rowWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width < 780
                ? double.infinity
                : 700,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(
              MediaQuery.of(context).size.width < 600 ? 20 : 40,
            ),
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
                    const Expanded(
                      child: Text(
                        'Create a Promotion',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textBlack),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                _buildLabel('Promotion Title'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller.titleController,
                  'Enter promotion title..',
                ),

                const SizedBox(height: 24),

                _buildLabel('Promotion Description'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller.descriptionController,
                  'Enter promotion description..',
                  maxLines: 4,
                ),

                const SizedBox(height: 24),

                _buildLabel('Promotion URL'),
                const SizedBox(height: 8),
                _buildTextField(
                  controller.urlController,
                  'Enter promotion URL..',
                ),

                const SizedBox(height: 24),

                _buildLabel('Promotion Image'),
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
                          : controller.createPromotion,
                      child: controller.isLoading.value
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: AppColors.rowWhite,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Create',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                  ),
                ),
              ],
            ),
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
    String hintText, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: textController,
      maxLines: maxLines,
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
