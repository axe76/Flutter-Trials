import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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

  void _setFavValue(bool newValue){
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavourite(String token, String userId) async{
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners(); //kinda like setState but for all listeners. Triggers rebuild of respective listeners
    final url = Uri.parse('https://flutter-shop-app-b8243-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$token');
    try{
      final response = await http.put(url,body: json.encode(
          isFavourite
        )
      );
      if(response.statusCode>=400){ //here wehave to do this as http package doesnt throw its own error for patch, put and delete
        _setFavValue(oldStatus);
      }
    }catch(error){
      _setFavValue(oldStatus);
      
    }
    
  }
}