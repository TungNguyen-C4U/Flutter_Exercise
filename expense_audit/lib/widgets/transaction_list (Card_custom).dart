import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    /**
     * Wrap into ScrollFrame by set Container with height + SingleChildScrollView Widget
     * Note1: Without Scroll Widget in main, Yellow Error Banner still appear on softkeyboard
     * Note2: Row and Column by default is not scrollable
     */

    /**
     * ListView Widget has infinitive height <> Column's height == given screen
     * Basically, ListView = Column + SingleChildscrollview 
     * Note: MUST Wrap by Container => define height or throw error
     */
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  //BoxFit.cover <enum> fit inside direct parent's boundary
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover),
                ),
              ],
            )
          : ListView.builder(
              /**
         * Note 1: map(() {}) take list itself <> itemBuilder:() {} take number of items
         * Note 2: (required) itemBuilder take func - called by Flutter 
         * => call builder() for every new item it wants to render on screen! 
         * itemBuilder give BuildContext (is metaObj ~ position Widget in Widget tree) 
         * + index currently building
         */
              itemBuilder: (ctx, index) {
                // return the Widget should be built for current item
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        /** Container auto fill all the space when set alignment
                         * Still can resized by width & height
                         */
                        // alignment: Alignment.bottomCenter,
                        // constraints: BoxConstraints.tightForFinite(width: 200,),
                        margin: const EdgeInsets.symmetric(
                          /// (default) shape sized to its Child (Text->Rectangle)
                          // shape: BoxShape.circle,
                          vertical: 10,
                          horizontal: 15,
                        ),
                        padding: EdgeInsets.all(10),
                        transform: Matrix4.rotationZ(0.05),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Text(
                          // Access directly
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
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
                            transactions[index].title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              // How many items should be built
              itemCount: transactions.length,
            ),
    );
  }
}
