import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTx;

  TransactionList(this.transactions,this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? LayoutBuilder(builder: (ctx,constraints){
      return Column(
        children: [
          Text("No transactions yet", style: Theme.of(context).textTheme.title),
          SizedBox(height: 30,),
          Container(
            height: constraints.maxHeight * 0.6,
            child:Image.asset('assets/images/waiting.png',fit: BoxFit.cover,))
        ]
      );
    },) : ListView.builder(
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
              trailing: MediaQuery.of(context).size.width > 460 ? FlatButton.icon(
                label: Text("Delete"),
                icon: Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                onPressed: ()=>_deleteTx(transactions[index].id),
              ) : IconButton(
                icon: Icon(Icons.delete), 
                color: Theme.of(context).errorColor,
                onPressed: ()=>_deleteTx(transactions[index].id)),
            ),
          );
        },
        itemCount: transactions.length,
    );
  }
}
