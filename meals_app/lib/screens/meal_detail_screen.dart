import 'package:flutter/material.dart';

class MealDetail extends StatelessWidget {
  static const routeName = '/meal-detail';


  @override
  Widget build(BuildContext context) {

    final String id = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text("The meal - ${id}"),),
      body:Center(
      child:Text("The meal - ${id}"),
    )
    );
  }
}