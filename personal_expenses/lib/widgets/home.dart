import 'package:flutter/material.dart';

import './chart.dart';
import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class Home extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransactions => _userTransactions
      .where(
        (tx) => tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        ),
      )
      .toList();

  void _addTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );
    setState(() => _userTransactions.add(newTx));
  }

  void _deleteTransaction(String id) {
    setState(
      () => _userTransactions.removeWhere((element) => element.id == id),
    );
  }

  void _showAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => GestureDetector(
        onTap: () {},
        child: NewTransaction(_addTransaction),
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text('Personal expenses!'),
      actions: [
        IconButton(
            onPressed: () => _showAddTransaction(context),
            icon: Icon(Icons.add))
      ],
    );

    final containerHeight = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height);

    final chartWidget = (rate) => Container(
          child: Chart(_recentTransactions),
          height: containerHeight * rate,
        );

    final txListWidget = Container(
      child: TransactionList(_userTransactions, _deleteTransaction),
      height: containerHeight * 0.7,
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() => _showChart = val);
                    },
                  ),
                ],
              ),
            if (!isLandscape) chartWidget(0.3),
            if (!isLandscape) txListWidget,
            if (isLandscape) _showChart ? chartWidget(0.7) : txListWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddTransaction(context),
      ),
    );
  }
}
