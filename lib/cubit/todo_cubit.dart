import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todo_state.dart';
import 'package:todo_app/helpers/helper_db.dart';

class TodoCubit extends Cubit<TodoState>{
  DBHelper dbHelper;
  TodoCubit({required this.dbHelper}):super(TodoState(mTodo: [],));


  void fetchAllTodo(
    {
      int orderBy = 0, // 0 -> ASC, 1 -> DESC
      int priority = 0, // 0 -> all,
      int status = 2 // 2-> all, 0-> 0, 1-> 1,
    })async{

    var allTodo = await dbHelper.getAllTodos(
      orderBy: orderBy,
      priority: priority,
      status: status
    );

    emit(TodoState(mTodo: allTodo, orderValue: orderBy, priorityValue: priority, statusValue: status));
  }

  void changeTodoStatus(int id) async {
    bool check = await dbHelper.changeTodoStatus(id: id);
    if (check){
      int currentPriorityValue = state.priorityValue;
      int currentOrderValue = state.orderValue;
      int currentStatus = state.statusValue;
      fetchAllTodo(orderBy: currentOrderValue, priority: currentPriorityValue, status: currentStatus);
    }
  }

  Future <bool> deleteTodo(int id) async{
    bool check = await dbHelper.deleteTodo(id: id);
    if (check){
      int currentPriorityValue = state.priorityValue;
      int currentOrderValue = state.orderValue;
      int currentStatus = state.statusValue;
      fetchAllTodo(orderBy: currentOrderValue, priority: currentPriorityValue, status: currentStatus);
    }
    return check;
  }

  // add Todo
  Future<bool> addTodo({required String title, required int priority})async{
    bool check = await dbHelper.addTodo(
        title: title,
        priority: priority

    );
    if(check){
      int currentPriorityValue = state.priorityValue;
      int currentOrderValue = state.orderValue;
      int currentStatus = state.statusValue;
      fetchAllTodo(orderBy: currentOrderValue, priority: currentPriorityValue, status: currentStatus);
    }
    return check;
  }

  void changeStatus({required int newStatus}){
    int currentPriorityValue = state.priorityValue;
    int currentOrderValue = state.orderValue;
    fetchAllTodo(orderBy: currentOrderValue, priority: currentPriorityValue, status: newStatus);
  }

  void changePriority({required int newPriority}){
    int currentOrderValue = state.orderValue;
    int currentStatus = state.statusValue;
    fetchAllTodo(orderBy: currentOrderValue, priority: newPriority, status: currentStatus);
  }

  void changeOrder({required int newOrder}){
    int currentStatus = state.statusValue;
    int currentPriority = state.priorityValue;
    fetchAllTodo(orderBy: newOrder, priority: currentPriority, status: currentStatus);
  }

}