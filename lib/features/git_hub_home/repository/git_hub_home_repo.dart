import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inilabs_assignment/utils/app_constants.dart';

class GitHubHomeRepo{
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.apiBaseUrl));

  Future<List<dynamic>> getUserRepos(String username) async {
    debugPrint("---------------------------------------------");
    debugPrint('Fetching repos for user: $username');
    final response = await _dio.get('${AppConstants.userUrl}$username${AppConstants.reposUrl}');
    debugPrint("---------------------------------------------");
    debugPrint("Response Data: ${response.data}");
    return response.data;
  }
}