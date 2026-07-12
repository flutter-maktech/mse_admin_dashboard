import 'package:get/get.dart';
import '../controllers/race_requests_controller.dart';
import '../../../data/providers/api_provider.dart';

class RaceRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RaceRequestsController>(
      () => RaceRequestsController(apiProvider: Get.find<ApiProvider>()),
    );
  }
}
