import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/todo_model.dart';

class SharedPreferenceService {
  // List<Todo> todoList
  Future<List<Todo>> getTodoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? jsonStringList = prefs.getStringList('Todo_List');

    if (jsonStringList != null) {
      return jsonStringList
          .map((todoString) => Todo.fromJson(jsonDecode(todoString)))
          .toList();
    }
    return [];
  }

  // Saving Data
  Future<void> saveTodoList(Todo todoInput) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Todo> inMemList = [];

    List<String>? jsonStringList = prefs.getStringList('Todo_List');
    if (jsonStringList != null) {
      inMemList = jsonStringList
          .map((todoString) => Todo.fromJson(jsonDecode(todoString)))
          .toList();
      inMemList.add(todoInput);
    } else {
      inMemList.add(todoInput);
    }

    List<String> todoStringList = inMemList
        .map((todoString) => jsonEncode(todoString.toJson()))
        .toList();
    await prefs.setStringList('Todo_List', todoStringList);
  }

  // Deleteing Data
  Future<void> deleteTodoList(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Todo> inMemList = [];

    List<String>? jsonStringList = prefs.getStringList('Todo_List');
    inMemList = jsonStringList!
        .map((todoString) => Todo.fromJson(jsonDecode(todoString)))
        .toList();
    inMemList.removeAt(index);

    List<String> todoStringList = inMemList
        .map((todoString) => jsonEncode(todoString.toJson()))
        .toList();
    await prefs.setStringList('Todo_List', todoStringList);
  }
}
