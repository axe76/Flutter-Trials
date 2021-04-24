import 'package:flutter/material.dart';

import '../models/transaction.dart';

import './new_transaction.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {

  final List<Transaction> _usertransactions = [
    Transaction(id: "t1",cost: 72.99, date: DateTime.now(), name: "Shoes"),
    Transaction(id: "t2",cost: 16.99, date: DateTime.now(), name: "Groceries"),
  ];

 void _addTransaction(String txname, double txamount){
  final newTx = Transaction(cost: txamount,name: txname,date: DateTime.now(),id: DateTime.now().toString());

  setState(() {
    _usertransactions.add(newTx);
  });
 }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addTransaction),
        TransactionList(_usertransactions),
      ],
      
    );
  }
}