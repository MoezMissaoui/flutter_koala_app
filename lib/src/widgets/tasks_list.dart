// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:koala/src/models/task.dart';
import 'package:koala/src/widgets/task_tile.dart';

class TasksList extends StatefulWidget {
  final List<Task> tasks;

  TasksList({
    required this.tasks,
  });

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        return TaskTile(
            isChecked: widget.tasks[index].isDone,
            taskTitle: widget.tasks[index].name,
            checkboxChange: (newValue) {
              setState(() {
                widget.tasks[index].doneChange();
              });
            });
      },
    );
  }
}
