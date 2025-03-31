import 'package:flutter/material.dart';
import 'package:meals_app/meals_app/components/category_grid_item.dart';
import 'package:meals_app/meals_app/data/dummy_data.dart';
import 'package:meals_app/meals_app/models/meal.dart';
import 'package:meals_app/meals_app/screens/meals_screen.dart';

import '../models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    List<Meal> filteredMeals;

    if (category.id == 'all') {
      filteredMeals = availableMeals;
    } else {
      filteredMeals =
          availableMeals
              .where((meal) => meal.categories.contains(category.id))
              .toList();
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final Category category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
    );
  }
}
