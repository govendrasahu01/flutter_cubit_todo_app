import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todo_cubit.dart';
import 'package:todo_app/cubit/todo_state.dart';
import 'package:todo_app/helpers/helper_app_routes.dart';
import 'package:todo_app/widgets/wid_app_bar.dart';
import 'package:todo_app/widgets/wid_bottom_navigation.dart';
import 'package:todo_app/widgets/wid_todo_list_builder.dart';

import '../widgets/wid_filter_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    context.read<TodoCubit>().fetchAllTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widAppBar(),
      bottomNavigationBar: widBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FilterBar(),
            Expanded(
              child: BlocBuilder<TodoCubit, TodoState>(builder: (ctx, state) {
                List<Map<String, dynamic>> allTodos = state.mTodo;
                return allTodos.isEmpty?  emptyView() : TodoListBuilder(allTodos: allTodos);
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, AppRoutes.addTodoPage);
      }, child: Icon(Icons.add),),
    );
  }

}


Center emptyView()=> Center(child: Text("Add your firs todo", style: TextStyle(
  fontFamily: "Poppins",
  fontWeight: FontWeight.bold,
  color: Colors.blueGrey.shade200,
  fontSize: 20
),),);


