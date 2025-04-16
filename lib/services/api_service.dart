import 'package:dio/dio.dart';

class ApiService {
  static const _token =
      '7b720424147b4bf4085f44e631c60c508e7a7e193594ae29e3fe762dd0f22458';
  static final _dio = Dio(BaseOptions(
    headers: {
      'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json'
    },
  ));

  static Future<Map<String, dynamic>?> createUser({
    required String name,
    required String email,
    required String gender,
  }) async {
    try {
      var response = await _dio.post(
        'https://gorest.co.in/public/v2/users',
        data: {
          'name': name,
          'email': email,
          'gender': gender,
          'status': 'active',
        },
      );
      if (response.statusCode == 201) {
        return response.data;
      }
    } catch (e) {
      print('Create Error: $e');
    }
    return null;
  }

  static Future<List<dynamic>> fetchUsers() async {
    try {
      var response = await _dio.get('https://gorest.co.in/public/v2/users');
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print('Fetch Error: $e');
    }
    return [];
  }
}
