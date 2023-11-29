import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key, 
    required this.onToggleFavorite, 
    required this.availabelMeals
  });

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availabelMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availabelMeals.where(
      (meal) => meal.categories.contains(category.id)
    ).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title, 
          meals: filteredMeals,
          onToggleFavorite: onToggleFavorite,
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Pick your category'),
      // ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItems(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              }
            )
        ],
      ),
    );
  }
}