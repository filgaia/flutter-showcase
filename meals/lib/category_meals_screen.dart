import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;

  // const CategoryMealsScreen(this.categoryId, this.categoryTitle, {Key? key})
  //    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    return Scaffold(
      // appBar: AppBar(title: Text(categoryTitle)),
      appBar: AppBar(title: Text(routeArgs['title']!)),
      body: Center(child: Text('The recipes for the category')),
    );
  }
}
