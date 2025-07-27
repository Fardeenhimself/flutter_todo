import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/todo_filter_provider.dart';
import 'package:flutter_todo/providers/todo_provider.dart';
import 'package:flutter_todo/utils/add_todo_box.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTodos = ref.watch(todoListProvider);
    final todos = ref.watch(filteredTodoProvider);
    final filter = ref.watch(todoFilterProvider);
    Widget content = Center(child: Text('Your todo\'s will appear here'));
    Widget content2 = Center(
      child: Text('Nothing to show here. Select another.'),
    );

    return Scaffold(
      appBar: AppBar(title: Text('ToDo\'s')),
      body: allTodos.isEmpty
          ? content
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SegmentedButton<TodoFilter>(
                    segments: const [
                      ButtonSegment(
                        value: TodoFilter.all,
                        label: Text('All Tasks'),
                      ),
                      ButtonSegment(
                        value: TodoFilter.complete,
                        label: Text('Completed Tasks'),
                      ),
                      ButtonSegment(
                        value: TodoFilter.incomplete,
                        label: Text('Remaining Tasks'),
                      ),
                    ],
                    selected: {filter},
                    onSelectionChanged: (newSelection) {
                      ref.read(todoFilterProvider.notifier).state =
                          newSelection.first;
                    },
                  ),
                ),
                Expanded(
                  child: todos.isEmpty
                      ? content2
                      : ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            final todo = todos[index];
                            return Dismissible(
                              background: Container(
                                color: Theme.of(context).colorScheme.error,
                                child: Icon(Icons.delete),
                              ),
                              key: ValueKey(todos[index]),
                              onDismissed: (direction) {
                                ref
                                    .read(todoListProvider.notifier)
                                    .deleteTodo(todo.id);
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text('Item removed'),
                                  ),
                                );
                              },
                              child: ListTile(
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
                              ),
                            );
                          },
                        ),
                ),
              ],
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


/* 

 */