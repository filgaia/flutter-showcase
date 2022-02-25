import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './adaptive_app_bar.dart';
import './chart.dart';
import './new_transaction.dart';
import './switch_chart.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
            const Duration(days: 7),
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

  void _switchChartVisibility(val) => setState(() => _showChart = val);

  Widget _chartWidget(double height, double rate) => SizedBox(
        child: Chart(_recentTransactions),
        height: height * rate,
      );

  List<Widget> _buildLandscape(double height, Widget txListWidget) => [
        SwitchChart(_showChart, _switchChartVisibility),
        _showChart ? _chartWidget(height, 0.7) : txListWidget
      ];

  List<Widget> _buildPortrait(double height, Widget txListWidget) => [
        _chartWidget(height, 0.3),
        txListWidget,
      ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = AdaptiveAppBar(
      'Personal expenses!',
      _showAddTransaction,
    );

    final containerHeight = (mediaQuery.size.height -
        mediaQuery.padding.top -
        appBar.preferredSize.height);

    final txListWidget = SizedBox(
      child: TransactionList(_userTransactions, _deleteTransaction),
      height: containerHeight * 0.7,
    );

    final appBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape) ..._buildLandscape(containerHeight, txListWidget),
            if (!isLandscape) ..._buildPortrait(containerHeight, txListWidget),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: appBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar as PreferredSizeWidget,
            body: appBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _showAddTransaction(context),
                  ),
          );
  }
}
