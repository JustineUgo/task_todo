import 'package:flutter/material.dart';
import 'package:todo/src/model/todo_model.dart';

class HomeProvider with ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> get todos => _todos.where((todo)=> todo.title.contains(_searchTerm) ).toList();

  String _searchTerm = '';
  String get searchTerm => _searchTerm;

  //Populate search
  void onSearch (String term){
    _searchTerm=term;
    notifyListeners();
  }

  // Fetch todos from the database
  Future<void> loadTodos() async {
    List<Map<String, dynamic>> todosList = [
      {
        'id': 0,
        'title': 'My first task for my cooking routine',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        'isCompleted': 0,
      },
      {
        'id': 1,
        'title': 'My second task for my driving routine',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        'isCompleted': 1,
      },
      {
        'id': 2,
        'title': 'My first task for my reading routine',
        'description':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
        'isCompleted': 0,
      },
    ];
    _todos = todosList.map((todoMap) => Todo.fromMap(todoMap)).toList();
    notifyListeners();
  }
}
