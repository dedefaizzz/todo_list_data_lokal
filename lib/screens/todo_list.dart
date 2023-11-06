import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/screens/add_page.dart';
import 'package:todo_list/services/todo_service.dart';
import 'package:todo_list/utils/snackBar_helper.dart';
import 'package:todo_list/widget/todo_card.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBgColor,
      appBar: _buildAppBar(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SearchBox(),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                    left: 5,
                  ),
                  child: Text(
                    'All My List',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 540,
              child: RefreshIndicator(
                onRefresh: fetchTodo,
                child: Visibility(
                  visible: items.isNotEmpty,
                  replacement: Center(
                    child: Text(
                      'Todo List Kosong',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: items.length,
                    padding: EdgeInsets.all(12),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      final item = items[index] as Map;
                      return TodoCard(
                          index: index,
                          item: item,
                          navigateEdit: NavigateToEditPage,
                          deleteById: deleteById);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          NavigateToAddPage(context);
        },
        label: Text('Add Todo'),
      ),
    );
  }

  // API get data
  Future<void> fetchTodo() async {
    final response = await TodoService.fetchTodos();

    // menampilkan data
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErrorMessage(context, message: 'Sesuatu Terjadi Kesalahan');
    }

    setState(() {
      isLoading = false;
    });
  }

  // setelah ditambahkan item maka dapat me refresh (langsung memunculkan item) ke add page
  Future<void> NavigateToAddPage(BuildContext context) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> NavigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(todo: item), // passing data ke edit
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  // API untuk Delete
  Future<void> deleteById(String id) async {
    // Hapus item
    final isSuccess = await TodoService.deleteById(id);
    if (isSuccess) {
      // Hapus item dari list
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    } else {
      // Menampilkan error
      showErrorMessage(context, message: 'Gagal Menghapus');
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBgColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Text(
            'My List',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: tdBlack,
            ),
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Image.asset('assets/images/avatar.jpg'),
            ),
          ),
        ],
      ),
    );
  }

  // API response reaction
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            maxWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }
}
