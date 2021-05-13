import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItemTile extends StatelessWidget {
  final String id;
  final String prodId;
  final double price;
  final int quantity;
  final String title;

  CartItemTile(this.id,this.prodId,this.price,this.quantity,this.title);


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id), //Simply assigining a unique key to each item so that issues in rendering a list dont happen
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 10),
          margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
          ),
        ),//The colour of the rest of the pannel while swiping
      direction: DismissDirection.endToStart,
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(prodId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('\$${price}')
                )
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${price*quantity}'),
            trailing: Text('${quantity} x'),
          ),
        ),
      ),
    );
  }
}