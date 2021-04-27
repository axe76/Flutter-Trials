import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String,Object>> get getGroupedTransactions{
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for(int i = 0;i<transactions.length;i++){
        if(transactions[i].date.day == weekday.day &&
        transactions[i].date.month == weekday.month &&
        transactions[i].date.year == weekday.year){
          totalSum += transactions[i].amount;
        }
      }

      return {'day':DateFormat.E().format(weekday),'amount':totalSum};
    }).reversed.toList();
  }

  double get totalSpent{
    return getGroupedTransactions.fold(0.0, (previousValue, element) {
      return previousValue + element['amount'];
    });
  }
  
  @override
  Widget build(BuildContext context) {
    print(getGroupedTransactions);
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: getGroupedTransactions.map((data){
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(data['day'],data['amount'],
              totalSpent == 0.0 ? 0.0 : (data['amount'] as double)/totalSpent),
            );
          }).toList(),
          ),
      ),);
  }
}