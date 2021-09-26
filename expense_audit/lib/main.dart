import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './models/transaction.dart';

import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp()); // See Chapter 123

/// Keep MyApp to StatelessWiget to make sure AppBar not rebuild ///
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',

        ///DISTINGUISH textTheme FOR GLOBAL AND FOR ONLY appBarTheme///
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

/** REASON WHY CHANGE MyHomePage FROM STATELESS TO STATEFUL **
 * Before [Chaper 93]:
 * + addTransaction logic is staying on user_transaction.dart
 * + _userTransactions=[] is staying there too (Also class TransactionList())
 
 * After
 * Implement Modal.Bottom.Sheet (AppBar & Floating Action Button)
 * + Need Trigger _addNewTransaction( ) here which trigger setState() inside it
 * + Replace UserTransaction() by TransactionList() [which bring...
 * ... _userTransactions=[] to main.dart too]
 * All these thing need to reflect the UI so have to LIFT STATE UP!
 * 
 * IMPORTANT: Because _MyHomePageState is private Class so change all fuctions 
 * inside to private too (like _addNewTransaction())
 */
///
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/// only add WidgetsBindingObserver in State
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool _showChart = false;

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

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now() //DateTime.now(): Constructor | DateTime: Class//
          .toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    /** SOME NOTE ABOUT showModalBottomSheet **
   * See [mbs folder] + [Chapter 93]:
   * showModalBottomSheet.Container vs showModalBottomSheet.gestureDetecture
   * [NOTE]: 
   * Can get rid of SingleScrollView in new_transaction.dart by using here
   */
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: NewTransaction(_addNewTransaction),
            ),
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransactions {
    // function returns true -> item is kept into newly returned list
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  List<Widget> _buildLandscapeContent(AppBar appBar, Widget txListWidget) {
    return [
      Row(
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.headline6, // See [Chapter 133]
          ),
          // See [Chapter 124 & 130]
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(AppBar appBar, Widget txListWidget) {
    return [
      Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txListWidget
    ];
  }

  Widget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Flutter App',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min, //NOTE2 [Chapter 131]
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Flutter App',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = _buildAppBar(); // See [Chapter 131]

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // NOTE: weight take infinity => crossAxis not apply
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape) ..._buildLandscapeContent(appBar, txListWidget),
            if (!isLandscape) ..._buildPortraitContent(appBar, txListWidget),
            // UserTransactions()
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            // one Floating Button per page
            floatingActionButtonLocation: Platform.isIOS
                ? Container()
                : FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _startAddNewTransaction(context),
              child: Icon(Icons.add),
            ),
          );
  }
}
