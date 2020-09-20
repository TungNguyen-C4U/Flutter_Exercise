import 'package:flutter/material.dart';

import './models/transaction.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/user_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(), /**DateTime.now(): Constructor */
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: (){},// Do nothing, avoid sheet closed
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),

      // Column takes as much width as its children need BUT infinity height
      //SingleChildScrollView: sroll view, shrink app.
      //=== Note: HAVE TO add in body not single widget wanted to scroll ORR...
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //NOTE: If weight take infinity so crossAxis not apply
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                elevation: 5,
                color: Colors.blue,
                /**
                 * Container is universal styling (How sth styled, sized, aligned)
                 * Card assumes the size of its child 
                 * - Parent is Container => Card takes it as a measurement 
                 * => crossAxisAligment.strech
                 * TextWidget takes as much space as Text needs
                 */
                child: Container(
                  width: double.infinity,
                  child: Text('CHART!'),
                ),
              ),
            ),
            TransactionList(_userTransactions),
            // UserTransactions()
          ],
        ),
      ),
      // one Floating Button per page
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
