import 'package:flutter/material.dart';
import 'package:koala/src/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> tasks = [
    Task(name: 'go shopping'),
    Task(name: 'buy a gift'),
    Task(name: 'travel to Brazil'),
    Task(name: 'repair the car'),
  ];

  void addTask(String newTaskTitle) {
    tasks.add(Task(name: newTaskTitle));
    notifyListeners();
  }

  void updateTask(Task task) {
    task.doneChange();
    notifyListeners();
  }

    void deleteTask(Task task) {
    tasks.remove(task);
    notifyListeners();
  }
}
