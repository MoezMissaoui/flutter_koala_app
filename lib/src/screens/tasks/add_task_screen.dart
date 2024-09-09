// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:koala/src/config/theme_colors.dart';

class AddTaskScreen extends StatelessWidget {
  final Function addTaskCallback;

  AddTaskScreen(this.addTaskCallback);

  @override
  Widget build(BuildContext context) {
    String? newTaskTitle;

    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Task',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 30,
                color: ThemeColors.mainColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40,
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newTaskTitle = newText;
            },
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            onPressed: () => {addTaskCallback(newTaskTitle)},
            child: Text('Add'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: ThemeColors.mainColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
