// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, sort_child_properties_last, avoid_unnecessary_containers, non_constant_identifier_names, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskTag extends StatefulWidget {
  final String taskName;
  final String taskDescription;
  final bool isCompleted;
  Function(bool?)? handleCheckOutTask;
  Function(BuildContext)? deleteFunction;

  TaskTag({
    super.key,
    required this.taskName,
    required this.taskDescription,
    required this.isCompleted,
    required this.handleCheckOutTask,
    required this.deleteFunction,
  });

  @override
  State<TaskTag> createState() => _TaskTagState();
}

class _TaskTagState extends State<TaskTag> {
  bool show = false;
  Widget icon = const Icon(Icons.arrow_forward_ios);

  void handleShowDocument() {
    if (show) {
      icon = const Icon(Icons.arrow_forward_ios);
    } else {
      icon = const Icon(Icons.arrow_back_ios);
    }
    show = !show;
    setState(() {
      icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                flex: 2,
                onPressed: widget.deleteFunction,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              )
            ],
          ),
          child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.amber[500],
              ),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(children: [
                        Checkbox(
                          value: widget.isCompleted,
                          onChanged: widget.handleCheckOutTask,
                          activeColor: Colors.amber[900],
                        ),
                        Center(
                            child: Text(
                          widget.taskName,
                          style: TextStyle(
                              fontSize: 18,
                              decoration: widget.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        )),
                      ]),
                    ),
                    IconButton(onPressed: handleShowDocument, icon: icon)
                  ],
                ),
                Visibility(
                  child: showDocumentSide(widget.taskDescription),
                  visible: show,
                ),
              ])),
        ));
  }
}

Container showDocumentSide(String text) {
  return Container(
    padding: EdgeInsets.all(10),
    width: double.infinity,
    child: Text(text),
  );
}
