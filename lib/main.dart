import 'package:flutter/material.dart';
import 'package:flutter_todo/screens/home_screen.dart';
import 'package:flutter_todo/utils/theme/dark_theme.dart';
import 'package:flutter_todo/utils/theme/light_theme.dart';

void main() {
  runApp(const TodoApp());
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
