import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todo_cubit.dart';
import 'package:todo_app/widgets/wid_app_bar.dart';

class AddTodoPage extends StatefulWidget {
  AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  int? priorityInput = 3;
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                "Add Todo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: "Poppins",
                  color: Colors.blueGrey
                ),
              ),
            ),
            SizedBox(height: 11,),
            // Title
            TextField(
              controller: titleController,
              minLines: 1,
              maxLines: 1,
              decoration: inputDecor(label: "Title"),
            ),
            SizedBox(height: 21,),
            SizedBox(height: 21,),
            // Priority
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.green.shade200,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    "Priority",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Ubuntu"
                    ),
                  )
                ),
                SizedBox(
                  width: 150,
                  child: RadioListTile(
                    title: Text("High"),
                    value: 3,
                    groupValue: priorityInput,
                    onChanged: (value){
                      setState(() {
                        priorityInput = value!;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  ),
                ),
              ],
            ),
            SizedBox(height: 11,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: RadioListTile(
                    title: Text("Mid"),
                    value: 2,
                    groupValue: priorityInput,
                    onChanged: (value){
                      setState(() {
                        priorityInput = value!;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: RadioListTile(
                    title: Text("Low"),
                    value: 1,
                    groupValue: priorityInput,
                    onChanged: (value){
                      setState(() {
                        priorityInput = value!;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  ),
                ),
              ],
            ),
            SizedBox(height: 42,),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white

                ),
                onPressed: ()async{
                  bool check = await context.read<TodoCubit>().addTodo(
                      title: titleController.text,
                      priority: priorityInput!,
                  );
                  if(check && context.mounted){
                    Navigator.pop(context);
                  }
                },
                child: Text("Save")
              ),
            )
          ],
        ),
      ),
    );
  }
}

InputDecoration inputDecor({required String label})=>InputDecoration(
  label: Text(label),
  contentPadding: EdgeInsets.symmetric(horizontal: 11, vertical: 8),
  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey, width: 1)),
  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey, width: 1)),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey, width: 1)),
);



