// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, unnecessary_new, use_build_context_synchronously, unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_list/dto/taskDto.dart';
import 'package:flutter_todo_list/screens/add_task_dialog.dart';
import 'package:flutter_todo_list/screens/menu_drawer.dart';
import 'package:flutter_todo_list/services/mutation/tasks/deleteTask.dart';
import 'package:flutter_todo_list/services/mutation/tasks/updateTask.dart';
import 'package:flutter_todo_list/services/query/findAllTasks.dart';
import 'package:flutter_todo_list/screens/taskTag.dart';
import 'package:flutter_todo_list/components/snackBar/showErrorMessage.dart';
import 'package:flutter_todo_list/components/snackBar/showSuccessMessage.dart';
import 'package:flutter_todo_list/utils/auth.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class TaskListProvider extends ChangeNotifier {
  final homeState = _HomePageState();
  // Future<void> reload() async {
  //   // Gọi hàm refresh() từ class HomeState
  //   // await homeState.refresh();
  // }
}

class _HomePageState extends State<HomePage> {
  late Future<List<Task>> futureTask;

  void handleCheckOut(bool? value, String taskId) async {
    var updateParams = {"id": taskId, "isComplete": value};

    var response = await onUpdateTask(updateParams);
    if (response.data['statusCode'] == 200) {
      showSuccessMessage(context, response.data['description']);
      refresh();
    } else {
      showErrorsMessage(context, response.data['description']);
    }
  }

  void deleteTask(String taskId) async {
    var response = await onDeleteTask(taskId);
    if (response.data['statusCode'] == 204) {
      showSuccessMessage(context, response.data['description']);
      refresh();
    } else {
      showErrorsMessage(context, response.data['description']);
    }
  }

  void logOut(){
    Auth.logout(context);
  }

  Future<void> refresh() async {
    setState(() {
      futureTask = fetchTasks();
    });
  }

  void openAddTaskDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AddTaskDialog(reload: refresh);
        });
  }

  @override
  void initState() {
    super.initState();
    futureTask = fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[400],
          title: Text(
            "Todo List",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        drawer: MenuDrawerPage(onPressed: logOut),
        body: Center(
          child: FutureBuilder<List<Task>>(
            future: futureTask,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];

                      final String id = data.id;
                      final String taskName = data.taskName;
                      final String taskDescription = data.taskDescription;
                      final bool isCompleted = data.isComplete;

                      return TaskTag(
                        taskName: taskName,
                        taskDescription: taskDescription,
                        isCompleted: isCompleted,
                        handleCheckOutTask: (value) =>
                            handleCheckOut(value, id),
                        deleteFunction: (BuildContext context) =>
                            deleteTask(id),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => openAddTaskDialog(context),
          // onPressed: () => HomePage().openAddTaskDialog(context),
          backgroundColor: Colors.deepPurple[300],
          child: Icon(Icons.add),
        ));
  }
}
