import 'package:get/get.dart';
import '../controllers/race_reports_controller.dart';
import '../../../data/providers/api_provider.dart';

class RaceReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RaceReportsController>(
      () => RaceReportsController(apiProvider: Get.find<ApiProvider>()),
    );
  }
}
