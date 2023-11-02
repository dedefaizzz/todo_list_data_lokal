import 'package:flutter/material.dart';
import 'package:todo_list/screens/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ToDo App',
      home: Home(),
    );
  }
}
