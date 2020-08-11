import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(AgeCalculatorApp());
}


class AgeCalculatorApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:  ThemeData(

      brightness: Brightness.light,
      accentColor: Colors.orangeAccent,
      primaryColor: Colors.orange,
      primarySwatch: Colors.orange,
      backgroundColor: Colors.yellow,
      highlightColor: Colors.yellow,
      splashColor: Colors.yellow,
    ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Age Calculator", style: TextStyle(color: Colors.white),),
        ),
        body: HomeScreen(),
      ),
    );
  }
}