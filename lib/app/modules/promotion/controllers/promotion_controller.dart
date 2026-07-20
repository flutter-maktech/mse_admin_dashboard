import 'package:get/get.dart';
import '../../../data/models/promotion_model.dart';
import '../../../data/providers/api_provider.dart';

class PromotionController extends GetxController {
  final rxPromotions = <PromotionModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchPromotions();
    super.onInit();
  }

  Future<void> fetchPromotions() async {
    try {
      isLoading.value = true;
      final promotions = await Get.find<ApiProvider>().getPromotions();
      rxPromotions.assignAll(promotions);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load promotions: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void deletePromotion(int id) async {
    try {
      isLoading.value = true;
      await Get.find<ApiProvider>().deletePromotion(id);

      Get.snackbar(
        'Success',
        'Promotion deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      fetchPromotions();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
