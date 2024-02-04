// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:to_do_app/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //initialise the hive.
  await Hive.initFlutter();
  runApp(const MyApp());

  //open box
  var box = await Hive.openBox('mybox');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primaryColor: Colors.yellow),
    );
  }
}
