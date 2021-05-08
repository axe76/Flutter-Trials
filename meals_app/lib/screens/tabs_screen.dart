import 'package:flutter/material.dart';
import '../models/meal.dart';

import '../widgets/main_drawer.dart';
import './favourites_screen.dart';
import './categories_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  TabsScreen(this.favouriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String,Object>> pagesList; 

  int _selectedIndex = 0;

  void _selectPage(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    pagesList = [
    {'screen':CategoriesScreen(),'title':'Categories'},
    {'screen':FavouritesScreen(widget.favouriteMeals),'title':'Favourites'},
    ];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pagesList[_selectedIndex]['title']),
        ),
        body: pagesList[_selectedIndex]['screen'],
        drawer: MainDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.shifting,
          backgroundColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.category),title: Text('Categories'),backgroundColor: Theme.of(context).primaryColor),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),title: Text('Favourites'),backgroundColor: Theme.of(context).primaryColor),
          ],
        ),
      );
  }
}