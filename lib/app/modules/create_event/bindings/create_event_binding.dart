import 'package:get/get.dart';
import '../controllers/create_event_controller.dart';
import '../../../data/providers/api_provider.dart';

class CreateEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateEventController>(
      () => CreateEventController(apiProvider: Get.find<ApiProvider>()),
    );
  }
}
