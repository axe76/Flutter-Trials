import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

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

      return {'day':DateFormat.E(weekday),'amount':totalSum};
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      
    );
  }
}