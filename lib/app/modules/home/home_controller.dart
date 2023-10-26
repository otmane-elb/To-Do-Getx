import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todogetx/app/data/models/task.dart';
import 'package:todogetx/app/data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});
  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;
  final tasks = <Task>[].obs;
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final doingtodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;
  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTask());
    ever(tasks, (_) => taskRepository.writeTask(tasks));
  }

  @override
  void onClose() {
    editController.dispose();
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTodods(List<dynamic> select) {
    doingtodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingtodos.add(todo);
      }
    }
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    } else {
      tasks.add(task);
      return true;
    }
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIndx = tasks.indexOf(task);
    tasks[oldIndx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  bool addTodo(String title) {
    var todo = {'title': title, 'done ': false};
    if (doingtodos.any(
      (element) => mapEquals<String, dynamic>(todo, element),
    )) {
      return false;
    }
    var trueTodo = {'title': title, 'done ': true};
    if (doneTodos.any(
      (element) => mapEquals<String, dynamic>(trueTodo, element),
    )) {
      return false;
    }
    doingtodos.add(todo);
    return true;
  }

  void updateTodos() {
    var newTtodos = <Map<String, dynamic>>[];
    newTtodos.addAll([...doingtodos, ...doneTodos]);
    var newTask = task.value!.copyWith(todos: newTtodos);
    int oldIndex = tasks.indexOf(task.value);
    tasks[oldIndex] = newTask;
    tasks.refresh();
  }
}
