import 'package:get/get.dart';
import '../../../data/models/race_model.dart';
import '../../../data/providers/api_provider.dart';

class RaceAdminController extends GetxController {
  final ApiProvider apiProvider;

  RaceAdminController({required this.apiProvider});

  final rxRaces = <RaceModel>[].obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRaces();
  }

  void fetchRaces() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final races = await apiProvider.getRaces();
      rxRaces.assignAll(races);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void deleteSeries(int id) async {
    try {
      // Optional: show loading overlay using Get.dialog
      await apiProvider.deleteRace(id);
      rxRaces.removeWhere((race) => race.id == id);
      Get.snackbar(
        'Success',
        'Race deleted successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
