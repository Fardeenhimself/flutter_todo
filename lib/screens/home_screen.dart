import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/todo_provider.dart';
import 'package:flutter_todo/utils/add_todo_box.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoListProvider);
    Widget content = Center(child: Text('Your todo\'s will appear here'));

    return Scaffold(
      appBar: AppBar(title: Text('ToDo\'s')),
      body: SafeArea(
        child: todos.isEmpty
            ? content
            : ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    title: Text(
                      todo.name,
                      style: TextStyle(
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text((todo.addedAt).toString()),
                    leading: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (ctx) => ref
                          .read(todoListProvider.notifier)
                          .toggleTodo(todo.id),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        ref.read(todoListProvider.notifier).deleteTodo(todo.id);
                        ScaffoldMessenger.of(context).clearSnackBars();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text('Item removed'),
                          ),
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
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
