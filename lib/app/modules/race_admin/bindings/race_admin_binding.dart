import 'package:get/get.dart';
import '../controllers/race_admin_controller.dart';
import '../../../data/providers/api_provider.dart';

class RaceAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<RaceAdminController>(
      () => RaceAdminController(apiProvider: Get.find<ApiProvider>()),
    );
  }
}
