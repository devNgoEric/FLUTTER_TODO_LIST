// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_new, non_constant_identifier_names, unused_local_variable, avoid_print, use_build_context_synchronously, unnecessary_this

import 'package:flutter_todo_list/services/mutation/tasks/craeteTask.dart';
import 'package:flutter_todo_list/components/snackBar/showErrorMessage.dart';
import 'package:flutter_todo_list/components/snackBar/showSuccessMessage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_list/utils/myBtn.dart';

class AddTaskDialog extends StatefulWidget {
  Function reload;
  AddTaskDialog({super.key, required this.reload });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final taskNameController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  String taskNameError = "Please enter state";
  String taskDescriptionError = "Please enter state";

  void onClose(BuildContext context) {
    setState(() {
      Navigator.of(context).pop();
    });
  }

  int validateTaskName(String values) {
    String patttern = r'(^[a-zA-Z0-9 ,.-]*$)';
    RegExp regExp = new RegExp(patttern);
    if (values.isEmpty || values.length == 0) {
      return 1;
    } else if (values.length < 10) {
      return 3;
    } else {
      return 0;
    }
  }

  int validateDescription(String values) {
    String patttern = r'(^[a-zA-Z0-9 ,.-]*$)';
    RegExp regExp = new RegExp(patttern);
    if (values.isEmpty || values.length == 0) {
      return 1;
    } else if (values.length < 10) {
      return 3;
    } else {
      return 0;
    }
  }

  Future<void> handleCreateTask() async {
    final body = {
      "taskName": taskNameController.text,
      "taskDescription": taskDescriptionController.text
    };

    var response = await onCreateTask(body);
    if (response.data['statusCode'] == 201) {
      showSuccessMessage(context, response.data['description']);
      Navigator.of(context).pop();
      this.widget.reload();
    } else {
      showErrorsMessage(context, response.data['description']);
      final error = response.data['errors']['value'];
      setState(() {
        taskNameError = error['taskName'];
        taskDescriptionError = error['taskDescription'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("New task here"),
        content: Container(
          height: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: Column(
                children: [
                  // input_zone(context, taskNameController,
                  //     "Enter task name here...", "Task Name", 1, 1),
                  input_text(taskNameController, validateTaskName, 1, 1,
                      "Enter task name here...", "Task Name", taskNameError),
                  SizedBox(height: 20),
                  input_text(
                      taskDescriptionController,
                      validateDescription,
                      5,
                      8,
                      "Enter task description here...",
                      "Task Description",
                      taskDescriptionError)
                ],
              )),
              footer(context, handleCreateTask, onClose)
            ],
          ),
        ));
  }
}

Row footer(BuildContext context, handleCreateTask, onClose) {
  return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    MyBtn(text: "Save", onPress: handleCreateTask),
    SizedBox(width: 5),
    MyBtn(text: "Cancel", onPress: () => onClose(context))
  ]);
}

TextField input_zone(
    BuildContext context, controller, hintText, labelText, minLine, maxLine) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.text,
    minLines: minLine,
    maxLines: maxLine,
    decoration: InputDecoration(
      hintText: hintText,
      labelText: labelText,
      border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.teal)),
      errorBorder: OutlineInputBorder(
        borderSide: new BorderSide(color: Colors.red, width: 0.0),
      ),
    ),
  );
}

TextFormField input_text(controller, validateContent, minLine, maxLine,
    hintText, labelText, errorText) {
  return TextFormField(
    controller: controller,
    autovalidateMode: AutovalidateMode.always,
    minLines: minLine,
    maxLines: maxLine,
    keyboardType: TextInputType.multiline,
    validator: (value) {
      int res = validateContent(value);
      if (res == 1) {
        return errorText;
      } else {
        return null;
      }
    },
    decoration: InputDecoration(
      border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.teal)),
      hintText: hintText,
      labelText: labelText,
    ),
  );
}
