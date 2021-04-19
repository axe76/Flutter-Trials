import 'package:flutter/material.dart';

void main() {
 runApp(MyApp()); //runs app with MyAPP as core widget. Flutter auto calls build funct
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(home: Text('Hello!')); //returns an object of widget class and calls its constructor with a Text widget 
  }
}