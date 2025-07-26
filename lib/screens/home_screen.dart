import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/todo_provider.dart';
import 'package:flutter_todo/utils/add_todo_box.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    return Scaffold(
      appBar: AppBar(title: Text('ToDo\'s')),
      body: SafeArea(
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return ListTile(
              title: Text(todo.name),
              subtitle: Text((todo.addedAt).toString()),
              trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (context) => AddTodoBox());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
