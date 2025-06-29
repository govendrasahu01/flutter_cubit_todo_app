import 'package:flutter/cupertino.dart';
import 'package:todo_app/pages/page_add_todo.dart';
import 'package:todo_app/pages/page_home.dart';

class AppRoutes{
  static final String home = "/";
  static final String addTodoPage = "/add-todo";

  static Map<String,WidgetBuilder> routes ={
    home:(_)=>HomePage(),
    addTodoPage: (_)=>AddTodoPage(),
  };
}