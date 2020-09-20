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
     * Note: Without Scroll Widget in main, Yellow Error Banner still appear on softkeyboard
     * Note2: Row and Column by default is not scrollable
     */

    /**
     * ListView is the Widget has infinitive height <> Column take all height it can in given screen
     * Basically ListView is column take a single child scroll view => Get rid of child: Column
     * Note: Has to be inside Container + height coz its infinitve height cause error
     */
    return Container(
      height: 300,
      child: ListView.builder(
        /**
         * Note 1: map(() {}) take list itself <> itemBuilder:() {} take number of items
         * Note 2: itemBuilder take func - called by Flutter which call builder() for every new titem it wants to render on screen 
         * => The func give BuildContext(metaObj ~ position Widget) + index currently building
         */
        itemBuilder: (ctx, index) {
          // return the Widget should be built for current item
          return Card(
            child: Row(
              children: <Widget>[
                /**
                 * Container:
                 * -Param 1: alignment: Alignment.center, 
                 * -Param 2: color: Colors.blue,
                 * Noteside: When set alignment it will expand to fill (color to view) its parent's width and height
                 * But then you can overwite by setting up  by: Param 3 or Param 4:
                 * -Param 3: width: 200, height: 100,
                 * -Param 4: (box layout model) constraints: BoxConstraints.tightForFinite(width: 200,),
                 * For more Styling you can combine Param 3 and Param 5:
                 * -Param 5: transform: Matrix4.rotationZ(0.05),
                 */ 
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  padding: EdgeInsets.all(10),

                  /**
                   * decoration: "Add shape to container"
                   * BoxDecoration:
                   * -Param 1: shape: BoxShape.circle,
                   * + By default, shape is sized to the container's child (TextWidget: Rectangle)
                   * -Param 2: color: Colors.blue,
                   * Noteside: If change shape, should combine with margin and padding for fitting content inside
                   */
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 2,
                    ),
                  ),
                  child: Text(
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
                      style: TextStyle(
                        color: Colors.grey,
                      ),
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
