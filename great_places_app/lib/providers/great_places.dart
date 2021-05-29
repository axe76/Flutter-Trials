import 'package:flutter/foundation.dart';
import 'dart:io';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier{
  List<Place> _items = [];

  List<Place> get items{
    return [..._items];
  }

  void addPlace(String title, File imageFile){
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: imageFile,
      location: null  
    );
    _items.add(newPlace);
    notifyListeners();
  }
}