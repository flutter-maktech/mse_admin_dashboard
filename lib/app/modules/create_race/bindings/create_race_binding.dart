import 'package:get/get.dart';
import '../controllers/create_race_controller.dart';
import '../../../data/providers/api_provider.dart';

class CreateRaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateRaceController>(
      () => CreateRaceController(apiProvider: Get.find<ApiProvider>()),
    );
  }
}
