import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/promotion_controller.dart';
import '../../../constants/app_colors.dart';
import '../../../data/models/promotion_model.dart';
import 'create_promotion_view.dart';
import 'update_promotion_view.dart';

class PromotionView extends GetView<PromotionController> {
  const PromotionView({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: AppColors.rowWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Dashboard button
            Container(
              width: double.infinity,
              color: AppColors.primaryRed,
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () => Get.back(),
                child: const Text(
                  'Promotions',
                  style: TextStyle(
                    color: AppColors.rowWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isMobile
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'All Promotion',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlack,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryRed,
                                  foregroundColor: AppColors.rowWhite,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CreatePromotionView(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text('Create Promotion'),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'All Promotion',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textBlack,
                              ),
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryRed,
                                  foregroundColor: AppColors.rowWhite,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CreatePromotionView(),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Create Promotion'),
                            ),
                          ],
                        ),
                  const SizedBox(height: 24),

                  // Table Body or Card Grid based on layout
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.all(48.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryRed,
                          ),
                        ),
                      );
                    }

                    if (controller.rxPromotions.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(
                          child: Text(
                            'No promotions available.',
                            style: TextStyle(color: AppColors.textBlack),
                          ),
                        ),
                      );
                    }

                    if (isMobile) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.rxPromotions.length,
                        itemBuilder: (context, index) {
                          final promotion = controller.rxPromotions[index];
                          return Card(
                            color: AppColors.rowGrey,
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: promotion.imageBytes != null
                                        ? Image.memory(
                                            promotion.imageBytes!,
                                            height: 60,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          )
                                        : (promotion.imageUrl != null &&
                                                promotion.imageUrl!.isNotEmpty)
                                            ? Image.network(
                                                promotion.imageUrl!,
                                                height: 60,
                                                width: 80,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    const Icon(
                                                  Icons.image_not_supported,
                                                  color: AppColors.iconGrey,
                                                ),
                                              )
                                            : const Icon(
                                                Icons.image,
                                                color: AppColors.iconGrey,
                                                size: 40,
                                              ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          promotion.title ?? 'N/A',
                                          style: const TextStyle(
                                            color: AppColors.textBlack,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _limitWords(promotion.subtitle),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppColors.textBlack
                                                .withValues(alpha: 0.7),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          promotion.url ?? 'N/A',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: AppColors.primaryRed,
                                            fontSize: 11,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: AppColors.textBlack,
                                    ),
                                    onPressed: () {
                                      _showActionDialog(context, promotion);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }

                    // Desktop Table layout
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Table Header
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.headerPink,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'Title',
                                  style: TextStyle(
                                    color: AppColors.textBlack
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                    color: AppColors.textBlack
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  'URL',
                                  style: TextStyle(
                                    color: AppColors.textBlack
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'Image',
                                  style: TextStyle(
                                    color: AppColors.textBlack
                                        .withValues(alpha: 0.7),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                width: 48,
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.rxPromotions.length,
                          itemBuilder: (context, index) {
                            final promotion = controller.rxPromotions[index];
                            final isEven = index % 2 == 0;

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              color: isEven
                                  ? AppColors.rowGrey
                                  : AppColors.rowWhite,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      promotion.title ?? 'N/A',
                                      style: const TextStyle(
                                        color: AppColors.textBlack,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      _limitWords(promotion.subtitle),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.textBlack,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      promotion.url ?? 'N/A',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.textBlack,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Center(
                                      child: promotion.imageBytes != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Image.memory(
                                                promotion.imageBytes!,
                                                height: 40,
                                                width: 60,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : (promotion.imageUrl != null &&
                                                  promotion.imageUrl!.isNotEmpty)
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  child: Image.network(
                                                    promotion.imageUrl!,
                                                    height: 40,
                                                    width: 60,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        const Icon(
                                                      Icons
                                                          .image_not_supported,
                                                      color: AppColors.iconGrey,
                                                    ),
                                                  ),
                                                )
                                              : const Icon(
                                                  Icons.image,
                                                  color: AppColors.iconGrey,
                                                ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 48,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.more_vert,
                                          size: 20,
                                          color: AppColors.textBlack,
                                        ),
                                        onPressed: () {
                                          _showActionDialog(context, promotion);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showActionDialog(BuildContext context, PromotionModel promotion) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: const EdgeInsets.all(24),
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What do you want to do?',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Title: ${promotion.title ?? 'N/A'}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textBlack,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    if (promotion.id != null) {
                      controller.deletePromotion(promotion.id!);
                    }
                  },
                  child: const Text(
                    'Delete Promotion',
                    style: TextStyle(color: AppColors.rowWhite, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: AppColors.primaryRed),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdatePromotionView(promotion: promotion),
                      ),
                    );
                  },
                  child: const Text(
                    'Update Promotion',
                    style: TextStyle(color: AppColors.primaryRed, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _limitWords(String? text, {int maxWords = 7}) {
  if (text == null || text.isEmpty) return 'N/A';
  final words = text.trim().split(RegExp(r'\s+'));
  if (words.length <= maxWords) return text;
  return '${words.take(maxWords).join(' ')}...';
}
