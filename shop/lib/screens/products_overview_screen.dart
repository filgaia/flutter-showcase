import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = [];

  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Shop')),
      body: const ProductsGrid(),
    );
  }
}
