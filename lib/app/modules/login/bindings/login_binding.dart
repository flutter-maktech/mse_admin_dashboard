import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../../../data/providers/api_provider.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<LoginController>(
      () => LoginController(apiProvider: Get.find<ApiProvider>()),
    );
  }
}
