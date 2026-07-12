import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/models/race_report_model.dart';
import '../../../data/providers/api_provider.dart';

class RaceReportsController extends GetxController {
  final ApiProvider apiProvider;
  
  RaceReportsController({required this.apiProvider});

  final rxReports = <RaceReportModel>[].obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchReports();
  }

  void fetchReports() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final reports = await apiProvider.getRaceReports();
      // Sort by created_at descending (newest first)
      reports.sort((a, b) {
        if (a.createdAt == null || b.createdAt == null) return 0;
        return DateTime.parse(b.createdAt!).compareTo(DateTime.parse(a.createdAt!));
      });
      rxReports.assignAll(reports);
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
