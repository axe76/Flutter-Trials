import 'package:flutter/material.dart';

class CategoryMeals extends StatelessWidget {

  static const routeName = 'category-meals';

  @override
  Widget build(BuildContext context) {
    
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,String>;
    final String catTitle = routeArgs['title']; 
    return Scaffold(
      appBar: AppBar(title: Text(catTitle)),
      body: Center(
        child: Text("Meals for this category"),
      )
    );
  }
}