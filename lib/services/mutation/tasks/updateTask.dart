

// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_todo_list/config.dart';

dynamic onUpdateTask(Object data) async {
  final dio = Dio();

  final String baseURL = Config.baseUrl.toString();
  final String uri = '$baseURL/tasks';

  try {
    final Response response = await dio.patch(uri, data: data);
    return response;
  } catch (error) {
    print(error);
  }

}