import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/todo_provider.dart';
import 'package:todo/screens/add_todo.dart';
import 'package:todo/screens/todo_detail.dart';
import 'package:todo/screens/todo_edit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<TodoProvider>().getTodoList;

    return Scaffold(
      appBar: AppBar(
        title: Text("Todos List"),

        centerTitle: true,
        backgroundColor: Colors.blue[300],
        actions: [
          Consumer(
            builder: (ctx, value, val) {
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
      body: Container(
        margin: EdgeInsets.all(8),
        child: Consumer<TodoProvider>(
          builder: (ctx, _, __) {
            return FutureBuilder(
              future: ctx.watch<TodoProvider>().getTodoList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    child: snapshot.data!.isNotEmpty
                        ? ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                padding: const EdgeInsets.all(2.0),
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white70,
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black54,
                                  ),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TodoDetail(
                                          todo: snapshot.data![index],
                                        ),
                                      ),
                                    );
                                  },
                                  leading: Icon(Icons.view_cozy),
                                  title: Text(
                                    snapshot.data![index].title,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index].description,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  trailing: Wrap(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => TodoEdit(
                                                todo: snapshot.data![index],
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context
                                              .read<TodoProvider>()
                                              .deleteTodo(index);
                                        },
                                        icon: Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(child: Text("No Todo Yet")),
                  );
                } else {
                  return Center(child: Text("Error"));
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodo()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
