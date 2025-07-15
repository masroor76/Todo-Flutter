import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/provider/todo_provider.dart';
import 'package:todo/widgets/custom_widgets.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),

        centerTitle: true,
        backgroundColor: Colors.blue[300],
        actions: [
          Consumer(
            builder: (ctx, _, __) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Badge(
                  label: FutureBuilder(
                    future: ctx.watch<TodoProvider>().getTodoList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("");
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return Text("${snapshot.data?.length}");
                      } else {
                        return Text("");
                      }
                    },
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.work),
                    onPressed: () {},
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  hintText: "Title",
                  myController: titleController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  hintText: "Description",
                  myController: descriptionController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        descriptionController.text.isNotEmpty) {
                      context.read<TodoProvider>().addTodo(
                        Todo(
                          title: titleController.text,
                          description: descriptionController.text,
                        ),
                      );
                      titleController.clear();
                      descriptionController.clear();
                    }
                  },
                  child: Text("Add Todo"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
