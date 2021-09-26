import 'dart:io';

import 'package:expense_audit/widgets/adaptive_flat_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/** [Chapter 85] USING StatelessWidget BUT LIFT STATE UP IN [Chapter 94] **
 * See [Chapter 85 + 94] documents...
 */
///
class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate; // not final [receive value once user choose date]

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return; // Stop the execution
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop(); //Auto close Bottom Sheet when press 'Done'
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020), //Can not go back to 2019
      lastDate: DateTime.now(), //Can not go to the future!
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  /** WHY USING SingleChildScrollView IN BOTTOM SHEET MODEL
   * Soft-keyboard overlap it 
   * padding.bottom + 10 to give us enough space for one TextField 
   * *.viewInsets: How much space occupied view [by keyboard] + 10
   * 
   * See [Chapter 127] for better Solution
   */
  ///
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            /** CAUTION onSubmitted [TEXTFIELD] AND onPressed [FLATBUTTON] ** 
             * See more in [Chapter 91] document
            
             * TextField:
             * + onSubmitted: press 'Done' button == submit 
             * + onChanged  : fire every keystroke
             */
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number, //<static property>
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70, //More space between above TextField and this Row
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      child: Text(
                        'Add Transaction',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _submitData,
                    )
                  : RaisedButton(
                      child: Text('Add Transaction'),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).textTheme.button.color,
                      onPressed: _submitData,
                      // onPressed: () => addTx(___,___,), /// simple approach
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
