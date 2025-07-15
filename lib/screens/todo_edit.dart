import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';

class TodoEdit extends StatelessWidget {
  final Todo todo;
  const TodoEdit({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Todo"),

        centerTitle: true,
        backgroundColor: Colors.blue[300],
      ),
      body: Text(todo.title),
    );
  }
}
