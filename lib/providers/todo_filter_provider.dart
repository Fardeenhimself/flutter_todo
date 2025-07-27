import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/providers/todo_provider.dart';

enum TodoFilter { all, complete, incomplete }

final todoFilterProvider = StateProvider<TodoFilter>((ref) => TodoFilter.all);

final filteredTodoProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoFilterProvider);
  final todos = ref.watch(
    todoListProvider,
  ); //creating new todos so that it can be filtered

  switch (filter) {
    case TodoFilter.complete:
      return todos.where((todo) => todo.isCompleted).toList();
    case TodoFilter.incomplete:
      return todos.where((todo) => !todo.isCompleted).toList();
    case TodoFilter.all:
      return todos;
  }
});
