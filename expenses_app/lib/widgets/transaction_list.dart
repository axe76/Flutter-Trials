import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty ? Column(
        children: [
          Text("No transactions yet", style: Theme.of(context).textTheme.title),
          SizedBox(height: 30,),
          Container(
            height: 200,
            child:Image.asset('assets/images/waiting.png',fit: BoxFit.cover,))
        ]
      ) : ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
                      child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child:Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(child: Text('\$${transactions[index].amount}',style: TextStyle(fontWeight: FontWeight.bold),)),
                )),
              title: Text(transactions[index].title,style: Theme.of(context).textTheme.title,),
              subtitle: Text(DateFormat.yMMMMd().format(transactions[index].date)),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
