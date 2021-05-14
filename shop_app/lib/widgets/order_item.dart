import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../providers/orders.dart';

class OrderItemTile extends StatefulWidget {
  final OrderItem order;

  OrderItemTile(this.order);

  @override
  _OrderItemTileState createState() => _OrderItemTileState();
}

class _OrderItemTileState extends State<OrderItemTile> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(DateFormat.yMMMd().format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded? Icons.expand_less:Icons.expand_more),
              onPressed: (){
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if(_expanded) Container(
            padding: EdgeInsets.symmetric(vertical: 6,horizontal: 15),
            height: min(widget.order.products.length * 20.0 + 16.0, 100),
            child: ListView.builder(
              itemCount: widget.order.products.length,
              itemBuilder: (ctx,i){
                var pdt = widget.order.products[i];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pdt.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      '${pdt.quantity} x \$${pdt.price}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    )
                  ],
                );
              }
              ),
          )
        ]
      ),
    );
  }
}