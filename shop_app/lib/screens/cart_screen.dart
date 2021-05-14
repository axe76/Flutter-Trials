import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/cart_item.dart';
import '../providers/orders.dart';



class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart')),
      body: Column(
        children:[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',style: TextStyle(fontSize: 20),),
                  SizedBox(width:10),
                  Spacer(),
                  Chip(
                    label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',style: TextStyle(color: Theme.of(context).primaryTextTheme.title.color),),
                    backgroundColor: Theme.of(context).primaryColor,
                    ),
                  FlatButton(
                    onPressed: (){
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(), 
                        cart.totalAmount
                      );
                      cart.clear();  
                    }, 
                    child: Text('CHECKOUT'),
                    textColor: Theme.of(context).primaryColor,)
                ],
              ),  
            ),
          ),
          SizedBox(height: 10,),
          Expanded(//Cant put listview directly in column
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx,index){
                return CartItemTile(
                  cart.items.values.toList()[index].id, 
                  cart.items.keys.toList()[index],
                  cart.items.values.toList()[index].price, 
                  cart.items.values.toList()[index].quantity, 
                  cart.items.values.toList()[index].title);
              },
              )
          )
        ],
      ),
    );
  }
}