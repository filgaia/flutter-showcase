import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  static const routeName = '/product-detail';

  //const ProductDetailScreen(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text('title')),
    );
  }
}