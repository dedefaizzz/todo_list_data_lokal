import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list/constants/colors.dart';

// berkaitan dengan event handling
TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 10,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: submitData,
            child: Text('Submit'),
          )
        ],
      ),
    );
  }

  // Form handling
  Future<void> submitData() async {
    // get data dari form
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    // submit data ke server
    final url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    // tampilkan status sukses / gagal di dalam debug
    if (response.statusCode == 201) {
      // titleController.text = '';
      // descriptionController.text = '';
      showSuccessMessage('Todo Telah Ditambahkan');
    } else {
      showErrorMessage('Todo Gagal Ditambahkan');
    }
  }

  // API response reaction
  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: tdBgColor),
      ),
      backgroundColor: tdBlue,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: tdBgColor),
      ),
      backgroundColor: tdRed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
