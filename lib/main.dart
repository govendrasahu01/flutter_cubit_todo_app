import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todo_cubit.dart';
import 'package:todo_app/helpers/helper_app_routes.dart';
import 'package:todo_app/helpers/helper_db.dart';
import 'package:todo_app/pages/page_home.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => TodoCubit(dbHelper: DBHelper.getInstance()),
    child: MyApp(),
  ));
  // runApp(HomePage());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
    );
  }
}
