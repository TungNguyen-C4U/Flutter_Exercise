import 'package:flutter/cupertino.dart';

/// Blueprint of Dart Object


class Transaction {
  final String
      id; //runtime constant | Get when created but after that never changes
  final String title;
  final double amount;
  // DateTime is type base on predefined class | It is not primitive
  DateTime date;
  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
