import 'package:flutter/foundation.dart';

class Transaction{
  final String id;
  final String name;
  final double cost;
  final DateTime date;

  Transaction({
    @required this.id,
    @required this.name,
    @required this.cost,
    @required this.date,
  });
}