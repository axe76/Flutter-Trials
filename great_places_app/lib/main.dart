import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/great_places.dart';
import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/place_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx)=>GreatPlaces(),
        child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber
        ),
        //home: MyHomePage(title: 'Great Places'),
        routes: {
          '/':(ctx)=>PlacesListScreen(),
          AddPlacesScreen.routeName:(ctx)=>AddPlacesScreen(),
          PlaceDetailScreen.routeName:(ctx)=>PlaceDetailScreen()
        },
      ),
    );
  }
}

