import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/meal_item.dart';

class CategoryMeals extends StatelessWidget {

  static const routeName = 'category-meals';

  @override
  Widget build(BuildContext context) {
    
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,String>;
    final String catTitle = routeArgs['title']; 
    final String catId = routeArgs['id'];

    final catMeals = DUMMY_MEALS.where((meal) {
      return meal.categories.contains(catId);
    }).toList();


    return Scaffold(
      appBar: AppBar(title: Text(catTitle)),
      body: ListView.builder(itemBuilder: (ctx,index){
        return MealItem(
          id: catMeals[index].id,
          title: catMeals[index].title, 
          affordability: catMeals[index].affordability, 
          imgUrl: catMeals[index].imageUrl, 
          complexity: catMeals[index].complexity, 
          duration: catMeals[index].duration);
      },itemCount: catMeals.length,)
    );
  }
}