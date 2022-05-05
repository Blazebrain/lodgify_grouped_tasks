import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:window_size/window_size.dart';

import 'app/app.locator.dart';
import 'ui/shared/snackbar/setup_snackbar.dart';
import 'ui/views/tasks/task_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await setupSnackBarUI();

  // This ensures that the desktop screen does not go
  // below a width and height of 500 pixels
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Lodgify Grouped Tasks');
    setWindowMinSize(const Size(500, 500));
    setWindowMaxSize(Size.infinite);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lodgify Grouped Tasks',
        home: const TasksView(),
        navigatorKey: StackedService.navigatorKey,
      ),
    );
  }
}
