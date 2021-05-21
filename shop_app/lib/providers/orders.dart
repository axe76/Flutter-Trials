import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem{
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.dateTime,
    @required this.products});
}

class Orders with ChangeNotifier{
  List<OrderItem> _orders = [];

  List<OrderItem> get orders{
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async{
    final url = Uri.parse('https://flutter-shop-app-b8243-default-rtdb.firebaseio.com/orders.json');
    final response = await http.get(url);
    final List<OrderItem>loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String,dynamic>;
    if(extractedData == null){
      _orders = [];
      notifyListeners();
      return;
    }
    extractedData.forEach((ordId, ordData) {
      loadedOrders.add(OrderItem(
        id: ordId,
        amount: ordData['amount'],
        dateTime: DateTime.parse(ordData['dateTime']),
        products: (ordData['products'] as List<dynamic>).map((cartItem){
          return CartItem(
            id: cartItem['id'], 
            price: cartItem['price'], 
            title: cartItem['title'], 
            quantity: cartItem['quantity']
            );
        }).toList()
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async{
    final url = Uri.parse('https://flutter-shop-app-b8243-default-rtdb.firebaseio.com/orders.json');
    final timeStamp = DateTime.now();
    final response = await http.post(url,body:json.encode({
        'amount':total,
        'dateTime':timeStamp.toIso8601String(),
        'products':cartProducts.map((product) {
          return {
            'id':product.id,
            'title':product.title,
            'quantity':product.quantity,
            'price':product.price
          };
        }).toList(),
      }
      )
    );
    _orders.insert(0, OrderItem(
      id: json.decode(response.body)['name'],
      amount: total,
      dateTime: timeStamp,
      products: cartProducts,
      )
    );
    notifyListeners();
  }

}