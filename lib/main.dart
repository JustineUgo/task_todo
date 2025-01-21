import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/src/ui/home/home_provider.dart';
import 'package:todo/src/ui/home/home_screen.dart';

void main() {
  runApp(const Todo());
}

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 812),
        builder: (context, child) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context)=> HomeProvider())
          ],
          child: MaterialApp(
            title: 'TODO',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Satoshi',
              visualDensity: VisualDensity.adaptivePlatformDensity,
              brightness: Brightness.light,
              scaffoldBackgroundColor: const Color(0xFFFFFFFF),
              appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFFFFF), elevation: 0),
            ),
            home: const HomeScreen(),
          ),
        ),
      ),
    );
  }
}
