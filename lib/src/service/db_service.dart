import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseService {
  static Database? _database;


  // Open the database
  Future<Database> get database async {
    if (_database != null) return _database!;

    // If the database is null, create it
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create the table when the database is first created
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE todos(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      isCompleted INTEGER
    )
    ''');
  }

  // Insert a new Todo item
  Future<int> insertTodo(Map<String, dynamic> todo) async {
    Database db = await database;
    return await db.insert('todos', todo);
  }

  // Get all Todo items
  Future<List<Map<String, dynamic>>> getTodos() async {
    Database db = await database;
    return await db.query('todos');
  }

  // Update a Todo item
  Future<int> updateTodo(Map<String, dynamic> todo) async {
    Database db = await database;
    return await db.update('todos', todo, where: 'id = ?', whereArgs: [todo['id']]);
  }

  // Delete a Todo item
  Future<int> deleteTodo(int id) async {
    Database db = await database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
