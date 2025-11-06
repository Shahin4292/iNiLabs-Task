import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:inilabs_assignment/features/git_hub_search/model/git_hub_search_model.dart';
import 'package:inilabs_assignment/utils/app_constants.dart';

class GitHubSearchRepo {

  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.apiBaseUrl));

  Future<GitHubSearchModel?> getUser(String username) async {
    try {
      final response = await _dio.get('${AppConstants.userUrl}$username');

      debugPrint('Fetching user data for: $username');
      debugPrint('Response status: ${response.statusCode}');

      if (response.statusCode == 200 && response.data != null) {
        return GitHubSearchModel.fromJson(response.data);
      } else {
        debugPrint('Unexpected response: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.message}');
      if (e.response != null) {
        debugPrint('Response data: ${e.response?.data}');
      }
      return null;
    } catch (e) {
      debugPrint('Unknown error: $e');
      return null;
    }
  }
}
