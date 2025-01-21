import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/src/ui/home/home_provider.dart';
import 'package:todo/src/ui/home/widget/task_tile.dart';
import 'package:todo/src/ui/task/task_screen.dart';
import 'package:todo/src/util/extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchTerm = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().loadTodos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Task Manager',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Welcome back!',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create, edit & delete all your tasks gracefully.',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CupertinoSearchTextField(
                      placeholder: 'Search by title',
                      borderRadius: BorderRadius.circular(20.r),
                      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                      onChanged: (value) {
                        context.read<HomeProvider>().onSearch(value);
                      },
                    ),
                    SizedBox(height: 30.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Consumer<HomeProvider>(
                          builder: (context, todoProvider, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'UNCOMPLETED (${todoProvider.todos.uncompleted.length})',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Column(
                                      children:
                                          todoProvider.todos.uncompleted.map((todo) => TaskTile(todo: todo)).toList(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'COMPLETED (${todoProvider.todos.completed.length})',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Column(
                                      children:
                                          todoProvider.todos.completed.map((todo) => TaskTile(todo: todo)).toList(),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const TaskScreen()),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 16.sp),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.r), color: const Color(0xFF363ee8)),
                            child: Row(
                              children: [
                                Text(
                                  'Add Task',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                const CircleAvatar(backgroundColor: Color(0xFFfad975), child: Icon(CupertinoIcons.add))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
