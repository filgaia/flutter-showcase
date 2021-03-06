import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './widgets/home.dart';

void main() {
  /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]); */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      primarySwatch: Colors.purple,
      // Default
      // errorColor: Colors.red,
      fontFamily: 'Quicksand',
      textTheme: ThemeData.light().textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          button: const TextStyle(color: Colors.white)),
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return MaterialApp(
      title: 'Personal expenses',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.amber),
      ),
      home: const Home(),
    );
  }
}
