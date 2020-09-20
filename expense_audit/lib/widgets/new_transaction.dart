import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  /// Purpose: Retrive adding Transaction function then wrap it with
  /// new input which take from controller of the TextField.
  ///
  /// After that trigger setState() in root StatefulWidget by call the wrapper
  /// through onPressed
  final Function addTx;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx);

  // could also pass String val inside this func and remove anomynous func in onSubmitted
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return; // Stop the execution
    }

    addTx(
      enteredTitle,
      enteredAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),

              /**Note: When hove onChange -> {void Function(String) onChanged} |  It fire every keystroke */
              // onChanged: (val) { titleInput = val; },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // This controller auto listen and save -- Test this in button print(titleController.text)
              controller: amountController,
              //TextInputType class got several static properties (like a bit enum but have complex value than number)
              keyboardType: TextInputType.number,/**IOS: TextInputType.numbeWithOptions(decimal:true) */
              // onChanged: (val) => amountInput = val,
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              // onPressed: () => addTx(___,___,),
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}
