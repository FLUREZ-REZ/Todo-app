import 'package:flutter/material.dart';
import 'package:todo/models/have-todo.dart';
import 'package:provider/provider.dart';

class saveTask extends ChangeNotifier {

  List<Task> _tasks = [

    Task(job: 'Exampletext1', Done: true),
    Task(job: 'Exampletext2', Done: false),
    Task(job: 'Exampletext3', Done: true),
    Task(job: 'Exampletext4', Done: true),
    Task(job: 'Exampletext5', Done: false),
    Task(job: 'Exampletext6', Done: false),
    Task(job: 'Exampletext7', Done: false),
    Task(job: 'Exampletext8', Done: false),
    Task(job: 'Exampletext9', Done: false),
    Task(job: 'Exampletext10', Done: false),
    Task(job: 'Exampletext11', Done: true),
    Task(job: 'Exampletext12', Done: true),
    Task(job: 'Exampletext13', Done: false),
    Task(job: 'Exampletext14', Done: true),

  ];

  List<Task> get tasks => _tasks;

  List<Task> get doneTasks =>
      _tasks.where((task) => task.Done == false).toList();

  List<Task> get completeTasks =>
      _tasks.where((mytask) => mytask.Done == true).toList();

  int _deletedCounter = 0  ;

  int get deletedCounter => _deletedCounter ;


void Addjob(Task task) {

 tasks.add(task);
 notifyListeners();

}

void Deletejob(Task task) {

  tasks.remove(task);
  _deletedCounter ++  ;
  notifyListeners();

}


void CheckTask (int index) {

  tasks[index].iscompleted();
  notifyListeners();
}

}