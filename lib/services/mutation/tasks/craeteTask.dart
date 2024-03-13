import 'package:dio/dio.dart';
import 'package:flutter_todo_list/config.dart';

dynamic onCreateTask(dynamic body) async {

  final dio = Dio();


  final String baseURL = Config.baseUrl.toString();
  final String uri = '$baseURL/tasks';

  try {
    final Response response = await dio.post('$uri', data: body);
    return response;
  } catch (error) {
    print(error);
  }
}
