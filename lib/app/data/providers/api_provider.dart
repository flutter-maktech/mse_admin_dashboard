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
}
