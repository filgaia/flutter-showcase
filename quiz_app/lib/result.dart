import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  const Result(this.resultScore, this.resetHandler);

  String get resultPhrase {
    String resultText;

    if (resultScore < 9) {
      resultText = 'You really rock with your likes!';
    } else if (resultScore < 13) {
      resultText = 'You\'re a nice person!';
    } else if (resultScore < 17) {
      resultText = 'You\'re weird...';
    } else {
      resultText = 'You\'re evil Mr. Bacon';
    }

    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text(
          resultPhrase,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: resetHandler,
          child: Text('Restart quiz!'),
          style: TextButton.styleFrom(
            primary: Colors.blue,
          ),
        ),
      ],
    ));
  }
}
