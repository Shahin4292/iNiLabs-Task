import 'package:dio/dio.dart';

class GitHubService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://api.github.com/'));

  Future<Map<String, dynamic>> getUser(String username) async {
    final response = await _dio.get('users/$username');
    return response.data;
  }

  Future<List<dynamic>> getUserRepos(String username) async {
    final response = await _dio.get('users/$username/repos');
    return response.data;
  }
}
