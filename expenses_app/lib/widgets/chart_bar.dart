import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.day,this.spendingAmount,this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container( //container given so that text widget height is restricted and the bar itself doesnt move up slightly for very large texts
          height: 20,
          child: FittedBox(
            child: Text(spendingAmount.toStringAsFixed(2))),
        ),
        SizedBox(height:4),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color:Colors.grey,width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                  ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                ),),
            ],),
        ),
        SizedBox(height:4),
        Text(day),
      ],
    );
  }
}