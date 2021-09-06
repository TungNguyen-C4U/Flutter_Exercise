import 'package:expense_audit/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

/** WHY DON'T USE StatefulWidget HERE **
 * [Chapter86] First using StatefuleW here because TransactionList is changing
 * Because:  
 * + "Assign" TransactionList to StatefulW UserTransaction which show it there
 * + _userTransactions=[] moving on user_transaction.dart to manage it there
 * + Also  
 * => Rollback to StatelessW 
 
 * FIRST VERSION OF LIST TRANSACTION (see ver1.0)
 * Using _userTransactions.map((tx) {return Card(<custom_build>)}).toList()
 */
/// ***
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Chart can't reach (landscape-mode) [List take full height]
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(
                  transaction: transactions[index],
                  deleteTx: deleteTx,
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
