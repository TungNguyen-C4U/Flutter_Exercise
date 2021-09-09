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
    /** WHAT IS addTx() **
     * addTx() actually is a Pointer
     * After wraped with new input - from controller of the TextField
     * => Trigger setState() in user_transaction.dart || main.dart
     * widget: give access to method/property from Widget_class in State_class
     * 
     */
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop(); //Auto close Bottom Sheet when press 'Done'
  }

  void _presentDatePicker() {
    // name_context_argm : class_property_context
    /**
     * then() provide func exec when future resolves to a value [choose a date]
     * Note: func pass inside then store in memory => continue exec code after it
     */
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  // ignore: slash_for_doc_comments
  /**Note: 
   * onChanged: (val) => enteredTitle = val,
   * Fire every keystroke, 
   * Require only one String argm => No need to define type 'val' 
   * <> Can't define enteredTitle final - Changing in runtime
   * => Stateless warning @immutable
   * => TextEditingController()
   */

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
            // How much space occupied by keyboard + 10
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            /** CAUTION onSubmitted [TEXTFIELD] AND onPressed [FLATBUTTON] ** 
             * onSubmitted: press 'Done' button == submit 
             * [Chapter 91]
             * Convention "_": Not have to define argm
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
                height: 70,
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
              RaisedButton(
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
