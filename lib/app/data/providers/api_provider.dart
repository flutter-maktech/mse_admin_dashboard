import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/app_constants.dart';
import '../models/event_model.dart';
import '../models/race_model.dart';
import '../models/race_request_model.dart';
import '../models/race_report_model.dart';

class ApiProvider extends GetConnect {
  final _storage = GetStorage();

  @override
  void onInit() {
    httpClient.baseUrl = AppConstants.apiBaseUrl;
    httpClient.addRequestModifier<dynamic>((request) {
      final token = _storage.read<String>('access_token');
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });
  }

  Future<String> adminLogin(String email, String password) async {
    final form = FormData({'username': email, 'password': password});

    final response = await post('/auth/user/login_for_admin', form);

    if (response.status.hasError) {
      return Future.error(
        response.body?['detail'] ?? response.statusText ?? 'Login failed',
      );
    }

    final token = response.body['access_token'];
    await _storage.write('access_token', token);
    return token;
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
      return Future.error(
        response.body?['detail'] ??
            response.statusText ??
            'Failed to update race',
      );
    }
  }

  Future<RaceModel> createRace(Map<String, dynamic> data) async {
    final response = await post('/race/', data);
    if (response.status.hasError) {
      return Future.error(
        response.body?['detail'] ??
            response.statusText ??
            'Failed to create race',
      );
    }
    return RaceModel.fromJson(response.body);
  }

  Future<EventModel> createEvent(Map<String, dynamic> data) async {
    final response = await post('/events/', data);
    if (response.status.hasError) {
      return Future.error(
        response.body?['detail'] ??
            response.statusText ??
            'Failed to create event',
      );
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
      return Future.error(
        response.body?['detail'] ??
            response.statusText ??
            'Failed to update event',
      );
    }
    return EventModel.fromJson(response.body);
  }

  Future<void> sendNotification(String message) async {
    final data = {'title': 'Notification', 'description': message};
    final response = await post('/promotions/', data);
    if (response.status.hasError) {
      return Future.error(
        response.body?['detail'] ??
            response.statusText ??
            'Failed to send notification',
      );
    }
  }

  Future<List<RaceRequestModel>> getRaceRequests() async {
    final response = await get('/request/');
    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Failed to load requests');
    } else {
      if (response.body is List) {
        return (response.body as List)
            .map((e) => RaceRequestModel.fromJson(e))
            .toList();
      } else {
        return Future.error('Invalid data format');
      }
    }
  }

  Future<List<RaceReportModel>> getRaceReports() async {
    final response = await get('/report/');
    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Failed to load reports');
    } else {
      if (response.body is List) {
        return (response.body as List)
            .map((e) => RaceReportModel.fromJson(e))
            .toList();
      } else {
        return Future.error('Invalid data format');
      }
    }
  }
}
