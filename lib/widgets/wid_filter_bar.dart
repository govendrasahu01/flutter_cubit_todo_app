
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/todo_state.dart';

import '../cubit/todo_cubit.dart';

class FilterBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(builder: (_, state) {
      return Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /*  Status Filter   */
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Status", style: TextStyle(color: Colors.blueGrey),),
                Container(
                  // width: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // color: Colors.blueAccent.shade100,
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      )
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: state.statusValue,
                      isDense: true,
                      items: [
                        DropdownMenuItem(value: 2,child: Text("All"),),
                        DropdownMenuItem(value:1,child: Text("Completed")),
                        DropdownMenuItem(value: 0, child: Text("Pending")),
                      ],
                      onChanged: (value){

                        context.read<TodoCubit>().changeStatus(newStatus: value!);

                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 5,),


            /*  Priority Filter   */
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Priority", style: TextStyle(color: Colors.blueGrey),),
                Container(
                  // width: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // color: Colors.blueAccent.shade100,
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      )
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: state.priorityValue,
                      isDense: true,
                      items: [
                        DropdownMenuItem(value: 0,child: Text("All"),),
                        DropdownMenuItem(value: 1,child: Text("Low"),),
                        DropdownMenuItem(value:2,child: Text("Medium")),
                        DropdownMenuItem(value: 3, child: Text("High")),
                      ],
                      onChanged: (value){
                        context.read<TodoCubit>().changePriority(newPriority: value!);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 5,),
            /*  Order by  */
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("order by",  style: TextStyle(color: Colors.blueGrey),),
                Container(
                  // width: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // color: Colors.blueAccent.shade100,
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      )
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: state.orderValue,
                      isDense: true,
                      items: [
                        DropdownMenuItem(value: 0,child: Text("ASC"),),
                        DropdownMenuItem(value:1,child: Text("DESC")),
                      ],
                      onChanged: (value){
                        context.read<TodoCubit>().changeOrder(newOrder: value!);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },);

  }
}
