import 'package:expense_audit/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

/** WHY DON'T USE StatefulWidget HERE **
 * [Chapter86] First using StatefuleW here because TransactionList is changing
 * But when we:  
 * + "Assign" TransactionList to StatefulW UserTransaction which show it there
 * + _userTransactions=[] moving on user_transaction.dart to manage it there
 * + Also setState() of fx _addNewTransaction() make it must LIFT STATE UP
 * => Rollback to StatelessW 
 
 * FIRST VERSION OF LIST TRANSACTION (see ver1.0)
 * Using _userTransactions.map((tx) {return Card(<custom_build>)}).toList()
 */
/// ***
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);
/** MANAGHE HEIGHT OF ENTIRE APP
 * See [Chapter 114 and 120]
 * MediaQuery v1.0: Define in both TransactionList and Chart
 * MediaQuery v2.0: Define in main with deduct other components's size
 */
  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      // height: MediaQuery.of(context).size.height * 0.6,
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
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover, //[Chapter 97]//
                    ),
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
