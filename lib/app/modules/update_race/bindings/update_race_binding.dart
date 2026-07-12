import 'package:get/get.dart';
import '../controllers/update_race_controller.dart';
import '../../../data/providers/api_provider.dart';

class UpdateRaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateRaceController>(
      () => UpdateRaceController(apiProvider: Get.find<ApiProvider>()),
    );
  }
}
