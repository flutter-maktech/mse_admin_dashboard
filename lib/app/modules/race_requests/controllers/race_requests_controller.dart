import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/models/race_request_model.dart';
import '../../../data/providers/api_provider.dart';

class RaceRequestsController extends GetxController {
  final ApiProvider apiProvider;
  
  RaceRequestsController({required this.apiProvider});

  final rxRequests = <RaceRequestModel>[].obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  void fetchRequests() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final requests = await apiProvider.getRaceRequests();
      // Sort by created_at descending (newest first)
      requests.sort((a, b) {
        if (a.createdAt == null || b.createdAt == null) return 0;
        return DateTime.parse(b.createdAt!).compareTo(DateTime.parse(a.createdAt!));
      });
      rxRequests.assignAll(requests);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  String formatDate(String? isoString) {
    if (isoString == null || isoString.isEmpty) return 'N/A';
    try {
      final date = DateTime.parse(isoString);
      return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
