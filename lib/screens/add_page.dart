import 'package:flutter/material.dart';
import 'package:todo_list/services/todo_service.dart';
import 'package:todo_list/utils/snackBar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({
    super.key,
    this.todo,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  // berkaitan dengan event handling
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  // alur edit data
  @override
  void initState() {
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;

      // isi ulang item (item sebelum di edit dpt muncul)
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // ternary - disini popup menu hny utk edit
          isEdit ? 'EditTodo' : 'Add Todo',
        ),
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
            onPressed: isEdit ? updateData : submitData,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                isEdit ? 'Update' : 'Submit',
              ),
            ),
          )
        ],
      ),
    );
  }

  // proses edit / update data
  Future<void> updateData() async {
    // put data dari form
    final todo = widget.todo;
    if (todo == null) {
      print('Kamu tidak bisa update data tanpa memasukkan data');
      return;
    }
    final id = todo['_id'];

    // update data ke server
    final isSuccess = await TodoService.updateTodo(id, body);

    // tampilkan status sukses / gagal di dalam debug
    if (isSuccess) {
      showSuccessMessage(context, message: 'Todo Telah Diupdate');
    } else {
      showErrorMessage(context, message: 'Todo Gagal Diupdate');
    }
  }

  Future<void> submitData() async {
    // submit data ke server
    final isSuccess = await TodoService.addTodo(body);

    // tampilkan status sukses / gagal di dalam debug
    if (isSuccess) {
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage(context, message: 'Todo Telah Ditambahkan');
    } else {
      showErrorMessage(context, message: 'Todo Gagal Ditambahkan');
    }
  }

  Map get body {
    // get data dari form
    final title = titleController.text;
    final description = descriptionController.text;
    return {
      "title": title,
      "description": description,
      "is_completed": false,
    };
  }
}
