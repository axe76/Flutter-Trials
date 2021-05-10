import 'package:flutter/foundation.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.description,
    @required this.title,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false});

  void toggleFavourite(){
    isFavourite = !isFavourite;
    notifyListeners(); //kinda like setState but for all listeners. Triggers rebuild of respective listeners
  }
}