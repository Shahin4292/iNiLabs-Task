import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inilabs_assignment/features/git_hub_home/model/git_hub_home_model.dart';
import 'package:inilabs_assignment/utils/app_constants.dart';

class GitHubHomeRepo{
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConstants.apiBaseUrl));

  Future<List<GitHubHomeModel>> getUserRepos(String username) async {
    try {
      final response = await _dio.get('${AppConstants.userUrl}$username${AppConstants.reposUrl}');
      debugPrint("Fetching repos for user: $username");
      debugPrint("Response: ${response.data}");

      if (response.statusCode == 200 && response.data != null) {
        return List<GitHubHomeModel>.from(
            response.data.map((repoJson) => GitHubHomeModel.fromJson(repoJson))
        );
      } else {
        return [];
      }
    } on DioException catch (e) {
      debugPrint("Dio error: ${e.message}");
      return [];
    } catch (e) {
      debugPrint("Unknown error: $e");
      return [];
    }
  }
}
