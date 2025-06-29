import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todo_cubit.dart';
import 'package:todo_app/cubit/todo_state.dart';

BottomAppBar widBottomNavigationBar()=> BottomAppBar(
  color: Colors.blueAccent.shade100,
  shape: CircularNotchedRectangle(),
  height: 60,
  child: BlocBuilder<TodoCubit,TodoState>(

    builder: (context, state) => Row(

      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        GestureDetector(
          onTap: (){context.read<TodoCubit>().changeStatus(newStatus: 2);},
          child: CircleAvatar(
            backgroundColor: state.statusValue == 2 ? Colors.blue : Colors.blueAccent.shade100,
            child: Icon(Icons.view_list,),
          ),
        ),
        GestureDetector(
          onTap: (){context.read<TodoCubit>().changeStatus(newStatus: 1);},
          child: CircleAvatar(
            backgroundColor: state.statusValue == 1 ? Colors.blue : Colors.blueAccent.shade100,
            child: Icon(Icons.task_alt,),
          ),
        ),
        GestureDetector(
          onTap: (){context.read<TodoCubit>().changeStatus(newStatus: 0);},
          child: CircleAvatar(
            backgroundColor: state.statusValue == 0 ? Colors.blue : Colors.blueAccent.shade100,
            child: Icon(Icons.hourglass_empty,),
          ),
        ),

      ],
    ),
  )
);