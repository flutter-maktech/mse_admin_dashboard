import 'package:get/get.dart';
import '../controllers/all_events_controller.dart';

class AllEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllEventsController>(() => AllEventsController());
  }
}
