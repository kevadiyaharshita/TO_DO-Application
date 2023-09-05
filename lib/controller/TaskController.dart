import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modals/TaskModal.dart';

class TaskController extends ChangeNotifier {
  SharedPreferences preferences;
  TaskController({required this.preferences});
  List<TaskModal> _allTask = [];
  late int _task_counter;
  List<String> SP_Task = [];

  get counter {
    _task_counter = preferences.getInt('task_counter') ?? 0;
    return _task_counter;
  }

  List<String> setSp_Task({required TaskModal task}) {
    SP_Task.clear();
    SP_Task.add(task.task);
    SP_Task.add(task.date);
    SP_Task.add(task.time);
    SP_Task.add(task.status);
    SP_Task.add(task.important);
    return SP_Task;
  }

  get allTaskList {
    _allTask.clear();
    for (int i = 0; i < counter; i++) {
      SP_Task = preferences.getStringList('Task : ${i}')!;
      TaskModal tm = TaskModal(
        task: SP_Task[0],
        date: SP_Task[1],
        time: SP_Task[2],
        status: SP_Task[3],
        important: SP_Task[4],
      );
      _allTask.add(tm);
    }
    return _allTask;
  }

  bool addTask({required TaskModal t1}) {
    _task_counter = counter;
    SP_Task = setSp_Task(task: t1);
    preferences.setStringList('Task : ${_task_counter}', SP_Task);
    preferences.setInt('task_counter', ++_task_counter);
    SP_Task.clear();
    _allTask.add(t1);
    notifyListeners();
    return true;
  }

  bool editTask({required TaskModal task, required int index}) {
    SP_Task = setSp_Task(task: task);
    preferences.setStringList('Task : ${index}', SP_Task);
    _allTask[index] = task;
    SP_Task.clear();
    try {
      notifyListeners();
    } catch (e) {
      print(";;;;");
    }
    return true;
  }

  void deleteTask({required int index}) {
    print("remove at:${index}");

    _allTask.removeAt(index);
    for (int i = 0; i < _allTask.length; i++) {
      print(_allTask[i].task);
      SP_Task = setSp_Task(task: _allTask[i]);
      preferences.setStringList('Task : ${i}', SP_Task);
    }
    preferences.setInt('task_counter', --_task_counter);
    notifyListeners();
  }
}
