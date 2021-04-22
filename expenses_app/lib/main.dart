import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter App"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              child: Text("CHART",style: TextStyle(color: Colors.white),),
              elevation: 5,),
          ),
          Card(child: Text("List of TX"),)
        ],)
    );
  }
}


