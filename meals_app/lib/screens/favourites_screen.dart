import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
 final List<Meal> favMeals;

 FavouritesScreen(this.favMeals);

  @override
  Widget build(BuildContext context) {
    if(favMeals.isEmpty){
      return Center(
      child: Text('No Favourites Yet'),
      );
    }else{
      return ListView.builder(itemBuilder: (ctx,index){
        return MealItem(
          id: favMeals[index].id,
          title: favMeals[index].title, 
          affordability: favMeals[index].affordability, 
          imgUrl: favMeals[index].imageUrl, 
          complexity: favMeals[index].complexity, 
          duration: favMeals[index].duration,);
      },itemCount: favMeals.length,);
    }
    
  }
}