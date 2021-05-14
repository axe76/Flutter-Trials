
import 'package:flutter/foundation.dart';

class CartItem{
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.title,
    @required this.quantity});
}

class Cart with ChangeNotifier{
  Map<String,CartItem> _items = {}; //Product Id: Cart Item

  Map<String,CartItem> get items{
    return {..._items};
  }

  int get itemCount{
    return _items.length;
  }

  double get totalAmount{
    var total = 0.0;
    _items.forEach((key, cartItem) { 
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String prodId, double price, String title){
    if(_items.containsKey(prodId)){
      _items.update(prodId, (existingCartItem) => CartItem(
        id:existingCartItem.id,
        price:existingCartItem.price,
        title:existingCartItem.title,
        quantity:existingCartItem.quantity+1));
    }else{
      _items.putIfAbsent(prodId, (){
        return CartItem(id: DateTime.now().toString(),title: title, price: price,quantity: 1);
        }
      );
    }
    notifyListeners();
  }

  void removeItem(String prodId){
    _items.remove(prodId);
    notifyListeners();
  }

  void clear(){
    _items = {};
    notifyListeners();
  }
}