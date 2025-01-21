import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, this.isCompleted = false});
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.r,
          height: 40.r,
          margin: EdgeInsets.only(right: 10.w),
          decoration: BoxDecoration(
            color: isCompleted ? Colors.grey.shade300 : null,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: isCompleted ? const Center(child: Icon(Icons.check)) : null,
        ),
        Flexible(
          child: Text(
            'This is the title of the task ' * 2,
            style: TextStyle(
              fontSize: 16.sp,
              color: isCompleted ? Colors.grey.shade700 : Colors.black,
              fontWeight: FontWeight.w500,
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          color: Colors.grey.shade200,
          onSelected: (value) {},
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
    );
  }
}
