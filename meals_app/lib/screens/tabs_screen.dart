import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import './favourites_screen.dart';
import './categories_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String,Object>> pagesList = [
    {'screen':CategoriesScreen(),'title':'Categories'},
    {'screen':FavouritesScreen(),'title':'Favourites'},
  ];

  int _selectedIndex = 0;

  void _selectPage(int index){
    setState(() {
      _selectedIndex = index;
    });
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