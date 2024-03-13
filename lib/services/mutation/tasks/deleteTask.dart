// ignore_for_file: avoid_print

import 'package:flutter_todo_list/config.dart';
import 'package:dio/dio.dart';

dynamic onDeleteTask(String taskId) async {
  final dio = Dio();

  final String baseURL = Config.baseUrl.toString();
  final String uri = '$baseURL/tasks/$taskId';

  try {
    final Response response = await dio.delete(uri);
    return response;
  } catch (e) {
    print('Error deleting task: $e');
    rethrow;
  }
}
