import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      /**
       * Note 1: map() lst_Objs<Transaction> => lst_Widgs<Card> By execute anonymous func on (tx)
       * Note 2: Because map() return Iterable => to.List() after map()
       * Note 3: Styling in Flutter == Working argms | argm of the it's wrapper
       * Note 4: Without anything else, Container sizes itself to its child
       */
      children: transactions.map((tx) {
        return Card(
          child: Row(
            children: <Widget>[
              Container(
                /// Add empty spaces surrounds widget (can be position Widget little more than padding)
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                /// Add empty spaces between child widget and the container boundary
                padding: EdgeInsets.all(10),
                
                
                decoration: BoxDecoration(
                  
                  border: Border.all(
                    color: Colors.purple,
                    width: 2,
                  ),
                ),
                
                child: Text(
                  '\$${tx.amount}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tx.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(tx.date),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
