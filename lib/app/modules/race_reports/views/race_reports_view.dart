import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/race_reports_controller.dart';
import '../../../constants/app_colors.dart';

class RaceReportsView extends GetView<RaceReportsController> {
  const RaceReportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.rowWhite,
      body: Center(
        child: Container(
          width: 700,
          margin: const EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            color: AppColors.rowWhite,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: const BoxDecoration(
                  color: AppColors.primaryRed,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.rowWhite),
                      onPressed: () => Get.back(),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Race Reports',
                        style: TextStyle(fontSize: 24, color: AppColors.rowWhite, fontWeight: FontWeight.w500),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: AppColors.rowWhite),
                      onPressed: controller.fetchReports,
                    ),
                  ],
                ),
              ),
              
              // List Content
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primaryRed));
                  }
                  
                  if (controller.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        controller.errorMessage.value,
                        style: const TextStyle(color: AppColors.primaryRed),
                      ),
                    );
                  }
                  
                  if (controller.rxReports.isEmpty) {
                    return const Center(child: Text('No reports found', style: TextStyle(color: AppColors.textBlack)));
                  }
                  
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.rxReports.length,
                    itemBuilder: (context, index) {
                      final report = controller.rxReports[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.rowWhite,
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              report.reportDetails ?? 'N/A',
                              style: const TextStyle(fontSize: 16, color: AppColors.textBlack, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            Text('User Name: ${report.userName ?? 'N/A'}', style: TextStyle(fontSize: 14, color: AppColors.textBlack.withOpacity(0.7))),
                            Text('User Email: ${report.userEmail ?? 'N/A'}', style: TextStyle(fontSize: 14, color: AppColors.textBlack.withOpacity(0.7))),
                            Text('Date: ${controller.formatDate(report.createdAt)}', style: TextStyle(fontSize: 14, color: AppColors.textBlack.withOpacity(0.7))),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
