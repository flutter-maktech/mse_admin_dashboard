import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/race_admin_controller.dart';
import '../../../constants/app_colors.dart';
import '../../../data/models/race_model.dart';

class RaceAdminView extends GetView<RaceAdminController> {
  const RaceAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.rowWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Action Buttons
            Row(
              children: [
                Expanded(
                  child: _buildHeaderButton(
                    'All Report',
                    onPressed: () => Get.toNamed('/race-reports'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildHeaderButton(
                    'Request Race',
                    onPressed: () => Get.toNamed('/race-requests'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildHeaderButton(
                    '+ Create a Race',
                    onPressed: () => Get.toNamed('/create-race'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Header Text & Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All Racing',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textBlack),
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: AppColors.primaryRed),
                  onPressed: () {
                    Get.toNamed('/send-notification');
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Table Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                color: AppColors.headerPink,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Racing', style: TextStyle(color: AppColors.textBlack.withOpacity(0.7))),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text('Logo', style: TextStyle(color: AppColors.textBlack.withOpacity(0.7)), textAlign: TextAlign.center),
                  ),
                  const SizedBox(width: 80),
                  const SizedBox(
                    width: 48,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.more_vert, size: 20, color: AppColors.textBlack),
                    ),
                  ),
                ],
              ),
            ),
            
            // Table Body
            Obx(() {
              if (controller.isLoading.value) {
                return const Padding(
                  padding: EdgeInsets.all(48.0),
                  child: Center(child: CircularProgressIndicator(color: AppColors.primaryRed)),
                );
              }
              if (controller.errorMessage.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(child: Text(controller.errorMessage.value, style: const TextStyle(color: AppColors.primaryRed))),
                );
              }
              if (controller.rxRaces.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Center(child: Text('No races found.', style: TextStyle(color: AppColors.textBlack))),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.rxRaces.length,
                itemBuilder: (context, index) {
                  final race = controller.rxRaces[index];
                  final isEven = index % 2 == 0;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    color: isEven ? AppColors.rowGrey : AppColors.rowWhite,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(race.name ?? 'Unknown', style: const TextStyle(color: AppColors.textBlack)),
                        ),
                        SizedBox(
                          width: 100,
                          child: Center(
                            child: (race.imageLogo != null && race.imageLogo!.isNotEmpty)
                                ? Image.network(
                                    race.imageLogo!,
                                    height: 30,
                                    width: 50,
                                    fit: BoxFit.contain,
                                    errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, color: AppColors.iconGrey),
                                  )
                                : const Icon(Icons.image, color: AppColors.iconGrey),
                          ),
                        ),
                        const SizedBox(width: 80),
                        SizedBox(
                          width: 48,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: const Icon(Icons.more_vert, size: 20, color: AppColors.textBlack),
                              onPressed: () {
                                _showActionDialog(context, race);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderButton(String text, {VoidCallback? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryRed,
        foregroundColor: AppColors.rowWhite,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  void _showActionDialog(BuildContext context, RaceModel race) {
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
                'What is you want to do?',
                style: TextStyle(fontSize: 18, color: AppColors.textBlack),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  onPressed: () {
                    Get.back();
                    if (race.id != null) {
                      controller.deleteSeries(race.id!);
                    }
                  },
                  child: const Text('Delete Series', style: TextStyle(color: AppColors.rowWhite, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: AppColors.primaryRed),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  onPressed: () {
                    Get.back();
                    Get.toNamed('/all-events', arguments: race);
                  },
                  child: const Text('All Event', style: TextStyle(color: AppColors.primaryRed, fontSize: 16)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryRed,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  onPressed: () {
                    Get.back();
                    Get.toNamed('/update-race', arguments: race);
                  },
                  child: const Text('Update Series', style: TextStyle(color: AppColors.rowWhite, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
