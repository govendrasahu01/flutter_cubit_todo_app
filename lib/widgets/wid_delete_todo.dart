import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todo_cubit.dart';


void deleteTodo({required int id, required title, required context}){
  showModalBottomSheet(context: context, builder: (context) => Container(
    height: 200,
    width: double.infinity,
    padding: EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 8),
    decoration: BoxDecoration(
     color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10)
      )
    ),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Text("Do you really want to delete?",style: TextStyle(
            fontSize: 20,
            color: Colors.red,
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 11,),
          Text(title, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.blueAccent.shade100,
          ),),
          SizedBox(height: 11,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  context.read<TodoCubit>().deleteTodo(id);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white
                ),
                child: Text("Yes"),
              ),
              SizedBox(width: 16,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white
                  ),
                  child: Text("No")
              ),
            ],
          )
        ],
      ),
    ),
  ));
}
