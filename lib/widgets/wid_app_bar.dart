import 'package:flutter/material.dart';
import 'package:todo_app/helpers/helper_db.dart';

AppBar widAppBar() => AppBar(
  title: Text("todo", style: TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: "Ubuntu",
    fontSize: 24,
  ),),
  backgroundColor: Colors.blueAccent,
);