import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:inilabs_assignment/utils/app_constants.dart';

class GitHubSearchRepo{
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.apiBaseUrl));

  Future<Map<String, dynamic>> getUser(String username) async {
    debugPrint('Fetching user data for: $username');
    debugPrint('Fetching: ${AppConstants.userUrl}$username');
    final response = await _dio.get('${AppConstants.userUrl}$username');
    debugPrint('Fetching user data for: $response');
    debugPrint('Fetching user data for: ${response.data}');
    return response.data;
  }
}