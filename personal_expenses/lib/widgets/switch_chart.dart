import 'package:flutter/material.dart';

class SwitchChart extends StatelessWidget {
  final bool showChart;
  final Function(bool) switchHandler;

  const SwitchChart(this.showChart, this.switchHandler);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Show chart',
          style: Theme.of(context).textTheme.headline6,
        ),
        Switch.adaptive(
          activeColor: Theme.of(context).colorScheme.secondary,
          value: showChart,
          onChanged: switchHandler,
        ),
      ],
    );
  }
}
