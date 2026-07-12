import 'package:get/get.dart';
import '../controllers/send_notification_controller.dart';
import '../../../data/providers/api_provider.dart';

class SendNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendNotificationController>(
      () => SendNotificationController(apiProvider: Get.find<ApiProvider>()),
    );
  }
}
