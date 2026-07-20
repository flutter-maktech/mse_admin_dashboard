import 'package:get/get.dart';
import '../controllers/create_promotion_controller.dart';

class CreatePromotionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreatePromotionController>(() => CreatePromotionController());
  }
}
