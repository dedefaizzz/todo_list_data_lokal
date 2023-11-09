// meng handle semua sqlite call (get, push, put, delete)
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/utils/database_helper.dart';

class TodoService {
  static Future<bool> deleteById(String id) async {
    try {
      Database db = await DatabaseHelper().database;
      int result = await db.delete('todos', where: 'id = ?', whereArgs: [id]);
      return result > 0;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>?> fetchTodos() async {
    try {
      Database db = await DatabaseHelper().database;
      List<Map<String, dynamic>> result = await db.query('todos');
      return result;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> updateTodo(String id, Map<String, dynamic> body) async {
    try {
      Database db = await DatabaseHelper().database;
      int result =
          await db.update('todos', body, where: 'id = ?', whereArgs: [id]);
      return result > 0;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addTodo(Map<String, dynamic> body) async {
    try {
      Database db = await DatabaseHelper().database;
      await db.insert('todos', body);
      return true;
    } catch (e) {
      return false;
    }
  }
}
