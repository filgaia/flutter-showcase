import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, Object>> get groupTransactionValues => List.generate(
        7,
        (index) {
          final weekDay = DateTime.now().subtract(Duration(days: index));
          double totalSum = 0.0;

          for (var i = 0; i < recentTransactions.length; i++) {
            if (recentTransactions[i].date.day == weekDay.day &&
                recentTransactions[i].date.month == weekDay.month &&
                recentTransactions[i].date.year == weekDay.year) {
              totalSum += recentTransactions[i].amount;
            }
          }

          print(DateFormat.E().format(weekDay));
          print(totalSum);

          return {
            'day': DateFormat.E().format(weekDay).substring(0, 2),
            'amount': totalSum,
          };
        },
      ).reversed.toList();

  double get maxSpending => groupTransactionValues.fold(
        0,
        (previousValue, element) =>
            previousValue + (element['amount'] as double),
      );

  @override
  Widget build(BuildContext context) {
    print(groupTransactionValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues
              .map(
                (e) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    e['day'] as String,
                    e['amount'] as double,
                    maxSpending == 0
                        ? 0
                        : (e['amount'] as double) / maxSpending,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
