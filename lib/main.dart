// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_todo_list/screens/home.dart';
import 'package:flutter_todo_list/screens/login.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskListProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // home: HomePage()
        // home: HomePage()
        initialRoute: '/login',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/login': (context) => LoginPage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/home': (context) => HomePage(),
        },
    ));
  }
}