import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

//to do box for hive
final todoBoxProvider = Provider<Box<Todo>>(
  (ref) => throw UnimplementedError(),
);

class ToDoNotifier extends StateNotifier<List<Todo>> {
  //hive box of todo's
  final Box<Todo> todoBox;

  ToDoNotifier(this.todoBox) : super(todoBox.values.toList());

  //add todo
  void addTodo(String name) {
    final newTodo = Todo(id: math.Random().nextDouble().toString(), name: name);
    todoBox.put(newTodo.id, newTodo);
    state = todoBox.values.toList();
  }
}

final todoListProvider = StateNotifierProvider<ToDoNotifier, List<Todo>>((ref) {
  final box = ref.watch(todoBoxProvider);
  return ToDoNotifier(box);
});
