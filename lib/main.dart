import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // utk system chrome
import 'package:todo_list/screens/todo_list.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false, // menghilangkan label debug
      title: 'ToDo App',
      home: ToDoListPage(),
    );
  }
}
