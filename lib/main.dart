import 'package:flutter/material.dart';
import 'home_page.dart';
void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.black12,

    ),
    title: 'Semi-Final Exam',
    home: const HomePage(),
  ));

}
