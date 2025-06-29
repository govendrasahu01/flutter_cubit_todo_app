import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/widgets/wid_delete_todo.dart';
import 'package:todo_app/widgets/wid_filter_bar.dart';
import '../cubit/todo_cubit.dart';
import '../helpers/helper_db.dart';

class TodoListBuilder extends StatelessWidget {
  List<Map<String,dynamic>> allTodos;
  TodoListBuilder({super.key,  required this.allTodos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: allTodos.length,
        itemBuilder: (_,index){
          // if(index ==0){
          //   return ;
          // }
          Color bgColor = Colors.green.shade200;
          String priorityText = "Might";

          if (allTodos[index][DBHelper.todoPriority] == 2){
            bgColor = Colors.brown.shade200;
            priorityText = "Should";
          }else if(allTodos[index][DBHelper.todoPriority] == 3){
            bgColor = Colors.red.shade300;
            priorityText ="Must";
          }

          if(allTodos[index][DBHelper.todoIsCompleted] == 1){
            bgColor = Colors.green;
            priorityText ="Done!";
          }


          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              color: bgColor,
              child: InkWell(
                onLongPress: () {
                  deleteTodo(title: allTodos[index][DBHelper.todoTitle],id : allTodos[index][DBHelper.todoId], context: context);
                },
                child: ListTile(
                    title: Text(allTodos[index][DBHelper.todoTitle], style: TextStyle(
                      decoration: allTodos[index][DBHelper.todoIsCompleted] ==1 ?TextDecoration.lineThrough:TextDecoration.none,
                    ),),
                    subtitle: Text(
                        allTodos[index][DBHelper.todoIsCompleted]==1?"Complete":"Pending"
                    ),
                    leading: Container(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Text(
                        priorityText,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red
                        ),
                      ),
                    ),
                    trailing: Checkbox(
                      value: allTodos[index][DBHelper.todoIsCompleted] == 1,
                      onChanged: (value){
                        context.read<TodoCubit>().changeTodoStatus(allTodos[index][DBHelper.todoId]);

                      },
                    ),

                ),
              ),
            ),
          );
        }
    );
  }
}
