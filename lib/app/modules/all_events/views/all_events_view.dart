import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/all_events_controller.dart';
import '../../../constants/app_colors.dart';

class AllEventsView extends GetView<AllEventsController> {
  const AllEventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: const Text('Dashboard', style: TextStyle(color: AppColors.rowWhite, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'All events',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textBlack),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryRed,
                          foregroundColor: AppColors.rowWhite,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        onPressed: () {
                          // Handle create event
                        },
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text('+ Create Event'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Table Header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: const BoxDecoration(color: AppColors.headerPink),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text('Channel', style: TextStyle(color: AppColors.textBlack.withOpacity(0.7)))),
                        Expanded(flex: 2, child: Text('Location', style: TextStyle(color: AppColors.textBlack.withOpacity(0.7)))),
                        Expanded(flex: 2, child: Text('Time', style: TextStyle(color: AppColors.textBlack.withOpacity(0.7)))),
                        Expanded(flex: 2, child: Text('Date', style: TextStyle(color: AppColors.textBlack.withOpacity(0.7)))),
                        const SizedBox(width: 48, child: Icon(Icons.visibility_off, size: 20)),
                      ],
                    ),
                  ),
                  
                  // Table Body
                  Obx(() {
                    if (controller.rxEvents.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Center(child: Text('No events available.', style: TextStyle(color: AppColors.textBlack))),
                      );
                    }
                    
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.rxEvents.length,
                      itemBuilder: (context, index) {
                        final event = controller.rxEvents[index];
                        final isEven = index % 2 == 0;
                        
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          color: isEven ? AppColors.rowGrey : AppColors.rowWhite,
                          child: Row(
                            children: [
                              Expanded(flex: 3, child: Text(event.tvBroadcastChanel ?? 'N/A', style: const TextStyle(color: AppColors.textBlack))),
                              Expanded(flex: 2, child: Text(event.location ?? 'N/A', style: const TextStyle(color: AppColors.textBlack))),
                              Expanded(flex: 2, child: Text(controller.formatTime(event.startedAt), style: const TextStyle(color: AppColors.textBlack))),
                              Expanded(flex: 2, child: Text(controller.formatDate(event.startedAt), style: const TextStyle(color: AppColors.textBlack))),
                              const SizedBox(
                                width: 48,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.more_vert, size: 20, color: AppColors.textBlack),
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
          ],
        ),
      ),
    );
  }
}
