import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: ListView(
        children: [
          TextField(),
          TextField(),
        ],
      ),
    );
  }
}
