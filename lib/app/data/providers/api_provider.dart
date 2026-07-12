import 'package:get/get.dart';
import '../../constants/app_constants.dart';
import '../models/race_model.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = AppConstants.apiBaseUrl;
  }

  Future<List<RaceModel>> getRaces() async {
    final response = await get('/race/');
    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Unknown error occurred');
    } else {
      if (response.body is List) {
        return (response.body as List)
            .map((item) => RaceModel.fromJson(item))
            .toList();
      }
      return [];
    }
  }

  Future<void> deleteRace(int id) async {
    final response = await delete('/race/$id');
    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Failed to delete race');
    }
  }

  Future<void> updateRace(int id, Map<String, dynamic> data) async {
    final response = await put('/race/$id', data);
    if (response.status.hasError) {
      return Future.error(response.body?['detail'] ?? response.statusText ?? 'Failed to update race');
    }
  }
}
