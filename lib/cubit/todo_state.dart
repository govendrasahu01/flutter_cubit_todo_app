import 'package:todo_app/helpers/helper_db.dart';

class TodoState{
  List<Map<String, dynamic>> mTodo;
  int statusValue;
  int priorityValue;
  int orderValue;


  TodoState({
    required this.mTodo,
    this.statusValue = 2,
    this.priorityValue = 0,
    this.orderValue = 0,
  });
}