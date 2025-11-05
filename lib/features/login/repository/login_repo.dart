import 'package:dio/dio.dart';
import 'package:inilabs_assignment/utils/app_constants.dart';

class LogRepo{
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.apiBaseUrl));

  Future<Map<String, dynamic>> getUser(String username) async {
    final response = await _dio.get('${AppConstants.userUrl}$username');
    return response.data;
  }
}