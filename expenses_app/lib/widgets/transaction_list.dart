import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Column(children: transactions.map((tx) {
            return Card(
              elevation: 4,
              child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: BoxDecoration(border: Border.all(color: Colors.purple, width: 2)),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$${tx.cost}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                      fontSize: 20,
                    ),),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    tx.name,
                    style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text(
                    DateFormat.yMMMMd().format(tx.date),
                    style: TextStyle(color: Colors.grey),)
                ],)
              ],),);
          } ).toList(),);
  }
}