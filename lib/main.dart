import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/providers/todo_provider.dart';
import 'package:flutter_todo/screens/home_screen.dart';
import 'package:flutter_todo/utils/theme/dark_theme.dart';
import 'package:flutter_todo/utils/theme/light_theme.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_todo/models/todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize hive
  await Hive.initFlutter();

  //Register the app for hive
  Hive.registerAdapter(TodoAdapter());
  final todoBox = await Hive.openBox<Todo>('todos');
  runApp(
    ProviderScope(
      //Essential for riverpod and hive to work
      //we declared a boxProvider in our provider
      //without it, it throws an error
      overrides: [todoBoxProvider.overrideWithValue(todoBox)],
      child: TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lighTheme,
      darkTheme: darkTheme,
      home: HomeScreen(),
    );
  }
}
