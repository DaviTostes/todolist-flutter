import 'package:flutter/material.dart';
import 'package:todolist/app_controller.dart';

import 'Homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'todoList',
          theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              brightness: AppController.instance.isDarkTheme
                  ? Brightness.dark
                  : Brightness.light),
          home: const HomePage(),
        );
      },
    );
  }
}
