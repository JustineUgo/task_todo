import 'package:flutter/material.dart';
import 'package:todo/src/model/todo_model.dart';
import 'package:todo/src/service/db_service.dart';
import 'package:todo/src/service/ui_service.dart';

class HomeProvider with ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  final UIService _uiService = UIService();

  List<Todo> _todos = [];
  List<Todo> get todos => _todos.where((todo) => todo.title.toLowerCase().contains(_searchTerm.toLowerCase())).toList();

  String _searchTerm = '';
  String get searchTerm => _searchTerm;

  //Populate search
  void onSearch(String term) {
    _searchTerm = term;
    notifyListeners();
  }

  // Fetch todos from the database
  Future<void> loadTodos() async {
    List<Map<String, dynamic>> todosList = await _dbService.getTodos();
    _todos = todosList.map((todoMap) => Todo.fromMap(todoMap)).toList();
    notifyListeners();
  }

  // Add a new todo
  Future<void> addTodo(Todo todo) async {
    await _dbService.insertTodo(todo.toMap());
    _uiService.showToast(text: 'Task successfully added!', type: ToastType.success);
    await loadTodos();
  }


  // Update a todo (e.g., toggle 'isCompleted')
  Future<void> updateTodo(Todo newTodo) async {
    var todo = _todos.firstWhere((todo) => todo.id == newTodo.id);
    todo = Todo(
      id: newTodo.id,
      title: newTodo.title,
      description: newTodo.description,
      isCompleted: newTodo.isCompleted,
    );

    await _dbService.updateTodo(todo.toMap());

    _uiService.showToast(text: 'Task updated!', type: ToastType.success);
    await loadTodos(); 
  }
}
