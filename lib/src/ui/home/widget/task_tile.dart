import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/src/model/todo_model.dart';
import 'package:todo/src/ui/home/home_provider.dart';
import 'package:todo/src/ui/task/task_screen.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.todo});
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return TaskScreen(todo: todo);
          }),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                context.read<HomeProvider>().updateTodo(
                      Todo(
                        id: todo.id,
                        title: todo.title,
                        description: todo.description,
                        isCompleted: !todo.isCompleted,
                      ),
                    );
              },
              child: Container(
                width: 40.r,
                height: 40.r,
                margin: EdgeInsets.only(right: 10.w),
                decoration: BoxDecoration(
                  color: todo.isCompleted ? Colors.grey.shade300 : null,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: todo.isCompleted ? const Center(child: Icon(Icons.check)) : null,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: todo.isCompleted ? Colors.grey.shade700 : Colors.black,
                      fontWeight: FontWeight.w500,
                      decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(
                    todo.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: todo.isCompleted ? Colors.grey.shade700 : Colors.black,
                      fontWeight: FontWeight.w400,
                      decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              color: Colors.grey.shade200,
              onSelected: (value) {
                if (value == 'edit') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return TaskScreen(todo: todo);
                    }),
                  );
                } else if (value == 'delete' && todo.id != null) {
                  context.read<HomeProvider>().deleteTodo(todo.id!);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.pen),
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.delete),
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}
