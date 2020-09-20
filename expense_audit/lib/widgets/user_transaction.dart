import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './new_transaction.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  // NOTE: the _userTransactions is holding pointer of List => _userTransactions = .. is Wrong
  //=> _userTransactions.add(value)
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Card',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Shoes',
      amount: 99.99,
      date: DateTime.now(),
    ),
  ];
  /**
   * Although this method is private but it just a Pointer so pass it down to Widget
   * and the create the Constructor in destination
   */
  // Note: txAmount expect double rather than String
  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id:DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
