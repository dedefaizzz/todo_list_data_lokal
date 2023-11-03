import 'package:flutter/material.dart';

// berkaitan dengan event handling
TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

class AddTodoPage extends StatelessWidget {
  const AddTodoPage({super.key});

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
            onPressed: () {},
            child: Text('Submit'),
          )
        ],
      ),
    );
  }

  // Form handling
  void submitData() {
    // get data dari form

    // submit data ke server
    // tampilkan status sukses / gagal
  }
}
