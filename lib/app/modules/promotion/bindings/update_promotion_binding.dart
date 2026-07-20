import 'package:get/get.dart';
import '../controllers/update_promotion_controller.dart';

class UpdatePromotionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePromotionController>(() => UpdatePromotionController(
      promotion: Get.arguments,
    ));
  }
}
