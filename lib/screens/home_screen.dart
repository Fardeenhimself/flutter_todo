import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/todo_filter_provider.dart';
import 'package:flutter_todo/providers/todo_provider.dart';
import 'package:flutter_todo/utils/add_todo_box.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTodos = ref.watch(todoListProvider);
    final todos = ref.watch(filteredTodoProvider);
    final filter = ref.watch(todoFilterProvider);
    Widget content = Center(
      child: Text(
        'Your todo\'s will appear here',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
    Widget content2 = Center(
      child: Text(
        'Nothing to show here. Select another.',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
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
                    segments: [
                      ButtonSegment(
                        value: TodoFilter.all,
                        label: Text(
                          'All Tasks',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ),
                      ButtonSegment(
                        value: TodoFilter.complete,
                        label: Text(
                          'Completed',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                        ),
                      ),
                      ButtonSegment(
                        value: TodoFilter.incomplete,
                        label: Text(
                          'Remaining',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                        ),
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
                      : ListView.separated(
                          itemCount: todos.length,
                          separatorBuilder: (context, index) => Divider(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          itemBuilder: (context, index) {
                            final todo = todos[index];
                            return Dismissible(
                              background: Container(
                                color: Theme.of(context).colorScheme.error,
                                margin: EdgeInsets.symmetric(
                                  horizontal: Theme.of(
                                    context,
                                  ).cardTheme.margin!.horizontal,
                                ),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                              key: ValueKey(todos[index]),
                              onDismissed: (direction) {
                                ref
                                    .read(todoListProvider.notifier)
                                    .deleteTodo(todo.id);
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    duration: Duration(seconds: 2),
                                    content: Text('Item removed'),
                                  ),
                                );
                              },
                              child: ListTile(
                                tileColor: todo.isCompleted
                                    ? Theme.of(
                                        context,
                                      ).colorScheme.secondaryContainer
                                    : null,
                                title: Text(
                                  todo.name,
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                        decoration: todo.isCompleted
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                ),
                                subtitle: todo.isCompleted
                                    ? Text('Done')
                                    : Text(
                                        'Added at: ${DateFormat.yMMMd().add_jm().format(todo.addedAt)}',
                                        //dateformat comes from intl package.
                                        //add_jm converts time into 12 hour human readable
                                      ),
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