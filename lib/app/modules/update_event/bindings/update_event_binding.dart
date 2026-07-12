import 'package:get/get.dart';
import '../controllers/update_event_controller.dart';
import '../../../data/providers/api_provider.dart';

class UpdateEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateEventController>(
      () => UpdateEventController(apiProvider: Get.find<ApiProvider>()),
    );
  }
}
