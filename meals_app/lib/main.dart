import 'package:flutter/material.dart';

import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          body1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          body2: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          title: TextStyle(
            fontSize:20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          )
        ),

      ),
      //home: TabsScreen(),
      routes: {
        '/': (ctx) => TabsScreen(),//default home
        CategoryMeals.routeName: (ctx) => CategoryMeals(),
        MealDetail.routeName: (ctx) => MealDetail(),
        FiltersScreen.routeName: (ctx)=>FiltersScreen(),
      },
      onGenerateRoute: (settings){//in case a route that hasnt been registered is accessed
        return MaterialPageRoute(builder: (ctx)=>CategoryMeals());
      },
      onUnknownRoute: (settings){//LAST CASE SCENARIO IF FLUTTER doesnt have a page to build
        return MaterialPageRoute(builder: (ctx)=>CategoryMeals());
      },
    );
  }
}


