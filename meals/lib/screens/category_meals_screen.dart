import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../data/dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';

  // const CategoryMealsScreen(this.categoryId, this.categoryTitle, {Key? key})
  //    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryId = routeArgs['id'];
    final categoryTitle = routeArgs['title']!;
    final categoryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryId))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle)),
      body: ListView.builder(
        itemBuilder: (ctx, index) => MealItem(
          id: categoryMeals[index].id,
          title: categoryMeals[index].title,
          affordability: categoryMeals[index].affordability,
          complexity: categoryMeals[index].complexity,
          duration: categoryMeals[index].duration,
          imageUrl: categoryMeals[index].imageUrl,
        ),
        itemCount: categoryMeals.length,
      ),
    );
  }
}
