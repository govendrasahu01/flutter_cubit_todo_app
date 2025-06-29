import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  DBHelper._();

  static DBHelper getInstance()=> DBHelper._();
  static final String todoTable = 'todo';
  static final String todoId = 'id';
  static final String todoTitle = 'title';
  static final String todoDescription = 'description';
  static final String todoIsCompleted = 'isCompleted';
  static final String todoPriority = 'priority';

  Database? db;

  Future<Database> initDB() async{
    if(db == null){
      Database myDB = await openDB();
      return myDB;
    }
    return db!;
  }

  Future<Database> openDB() async{
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, 'todo.db');
    return openDatabase(dbPath, version: 1, onCreate: (db, version){
      db.execute(
        '''create table $todoTable(
        $todoId integer primary key autoincrement,
        $todoTitle text,
        $todoDescription text,
        $todoIsCompleted integer,
        $todoPriority integer
        )'''
      );
    },);
  }

  // get all Todo
  Future<List<Map<String,dynamic>>> getAllTodos({
    int orderBy = 0, // 0 -> DESC, 1 -> ASC
    int priority = 0, // 0 -> all,
    int status = 2 // 2-> all, 0-> 0(pending), 1-> 1(completed),

  }) async{
      Database db = await initDB();
      String qOrder = "DESC";
      List<Map<String,dynamic>>? allTodos;

      if(orderBy == 1){qOrder = "ASC";}

      if(priority == 0 && status == 2 ){
        allTodos = await db.query(todoTable, orderBy: "$todoId $qOrder");
      }else if (priority == 0){
        // filter only for status
        allTodos = await db.query(
            todoTable,
            orderBy: "$todoId $qOrder",
            where: "$todoIsCompleted = ?",
            whereArgs: [status]
        );

      }else if(status == 2){
        // filter only for priority
        allTodos = await db.query(
            todoTable,
            orderBy: "$todoId $qOrder",
            where: "$todoPriority = ?",
            whereArgs: [priority]
        );
      }else{
        // filter for both status and priority
        allTodos = await db.query(
            todoTable,
            orderBy: "$todoId $qOrder",
            where: "$todoPriority = ? And $todoIsCompleted = ?",
            whereArgs: [priority, status]
        );
      }

      return allTodos!;
  }

  // add todo
  Future<bool> addTodo({
    required String title,
    required int priority
  })async{

    Database db = await initDB();
    int rowsAffected = await db.insert(todoTable, {
      todoTitle : title,
      todoDescription: "",
      todoPriority: priority,
      todoIsCompleted:0
    });
    return rowsAffected>0;
  }

  // delete Todo
  Future<bool> deleteTodo({required int id})async{
    Database db = await initDB();
    int rowsAffected = await db.delete(todoTable, where: "$todoId =?", whereArgs: [id]);
    return rowsAffected>0;
  }

  Future<bool> changeTodoStatus({required int id}) async{

      Database db = await initDB();
      var data = await db.query(todoTable, where: "$todoId = ?", whereArgs: [id]);

      int newVal = data[0][todoIsCompleted] == 1 ? 0:1;

      int rowAffected = await db.update(
          todoTable,
          {todoIsCompleted : newVal},
          where: "$todoId = ?",
          whereArgs: [id]
      );
      return rowAffected > 0;
    }

}