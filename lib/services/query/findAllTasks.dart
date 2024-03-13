import 'package:dio/dio.dart';
import 'package:flutter_todo_list/config.dart';
import 'package:flutter_todo_list/dto/taskDto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<List<Task>> fetchTasks() async {
  final storage = new FlutterSecureStorage();
  final token = await storage.read(key: "token");
  final dio = Dio();

  final String baseURL = Config.baseUrl.toString(); // http://host:port
  final String uri = '$baseURL/tasks';

  try {
    final Response response = await dio.get(uri,
        queryParameters: {},
        options: Options(
            contentType: 'application/json',
            responseType: ResponseType.json,
            headers: {'token': token}));

    if (response.data['statusCode'] == 201) {
      // If the server did return a 201 OK response,
      // then parse the JSON.
      List<Task> result = [];
      var data = response.data['data'];

      for (var i = 0; i < data.length; i++) {
        var task = Task.fromJson(data[i] as Map<String, dynamic>);
        result.add(task);
      }

      return result;
    } else {
      // If the server did not return a 201 OK response,
      // then throw an exception.
      throw Exception('Failed to load task');
    }
  } catch (error) {
    throw Exception('Failed to load task');
  }
}
