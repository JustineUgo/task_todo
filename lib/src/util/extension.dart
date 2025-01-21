import 'package:todo/src/model/todo_model.dart';

extension TaskExt on List<Todo>{
  List<Todo> get completed => where((test)=> test.isCompleted).toList();
  
  List<Todo> get uncompleted => where((test)=> !test.isCompleted).toList();
}