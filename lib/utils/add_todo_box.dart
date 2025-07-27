import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/todo_provider.dart';

class AddTodoBox extends ConsumerWidget {
  const AddTodoBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    return AlertDialog(
      title: const Text('Add New Todo'),
      content: TextField(
        controller: controller,
        maxLength: 25,
        decoration: InputDecoration(hintText: 'Enter task name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (controller.text.trim().isNotEmpty) {
              ref
                  .read(todoListProvider.notifier)
                  .addTodo(controller.text.trim());
              Navigator.of(context).pop();
            } else {
              Text('Fild cannot be empty');
            }
          },
          child: Text('Create'),
        ),
      ],
    );
  }
}
