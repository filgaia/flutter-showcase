import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double percentage;

  const ChartBar(this.label, this.amount, this.percentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      var sizedBox = SizedBox(height: constraints.maxHeight * 0.05);

      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text('\$ ${amount.toStringAsFixed(0)}')),
          ),
          sizedBox,
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          sizedBox,
          Container(
            child: FittedBox(child: Text(label)),
            height: constraints.maxHeight * 0.15,
          ),
        ],
      );
    });
  }
}
