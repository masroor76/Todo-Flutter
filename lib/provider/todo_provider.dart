import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/services/shared_pref.dart';

class TodoProvider extends ChangeNotifier {
  SharedPreferenceService prefsService = SharedPreferenceService();

  // final List<Todo> _todoList = [];

  Future<List<Todo>> get getTodoList async {
    var todoList = await prefsService.getTodoList();
    return todoList;
    // [..._todoList];
  }

  void addTodo(Todo todoInput) async {
    prefsService.saveTodoList(todoInput);
    await getTodoList;
    notifyListeners();
  }

  void deleteTodo(int index) async {
    // _todoList.removeAt(index);
    prefsService.deleteTodoList(index);
    await getTodoList;
    notifyListeners();
  }
}
