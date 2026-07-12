import 'package:get/get.dart';
import '../../constants/app_constants.dart';
import '../models/event_model.dart';
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

  Future<EventModel> createEvent(Map<String, dynamic> data) async {
    final response = await post('/events/', data);
    if (response.status.hasError) {
      return Future.error(response.body?['detail'] ?? response.statusText ?? 'Failed to create event');
    }
    return EventModel.fromJson(response.body);
  }

  Future<void> deleteEvent(int id) async {
    final response = await delete('/events/$id');
    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Failed to delete event');
    }
  }

  Future<EventModel> updateEvent(int id, Map<String, dynamic> data) async {
    final response = await put('/events/$id', data);
    if (response.status.hasError) {
      return Future.error(response.body?['detail'] ?? response.statusText ?? 'Failed to update event');
    }
    return EventModel.fromJson(response.body);
  }
}
