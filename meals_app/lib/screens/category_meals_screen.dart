import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../dummy_data.dart';
import '../widgets/meal_item.dart';

class CategoryMeals extends StatefulWidget {

  static const routeName = 'category-meals';

  final List<Meal> availableMeals;

  CategoryMeals(this.availableMeals);

  @override
  _CategoryMealsState createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
  String categoryTitle;
  List<Meal> displayMeals;
  var isInitialised = false;

  @override
  void didChangeDependencies() {//runs every time anything in the state changed. Runs multiple times after initialization
    if(!isInitialised){
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,String>;
      categoryTitle = routeArgs['title']; 
      final String catId = routeArgs['id'];

      displayMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(catId);
      }).toList();
    }
    

    isInitialised = true;
    super.didChangeDependencies();
  }

  void removeMeal(String mealId){
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(itemBuilder: (ctx,index){
        return MealItem(
          id: displayMeals[index].id,
          title: displayMeals[index].title, 
          affordability: displayMeals[index].affordability, 
          imgUrl: displayMeals[index].imageUrl, 
          complexity: displayMeals[index].complexity, 
          duration: displayMeals[index].duration,
          );
      },itemCount: displayMeals.length,)
    );
  }
}