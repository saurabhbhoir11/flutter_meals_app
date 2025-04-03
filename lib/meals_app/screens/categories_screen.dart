import 'package:flutter/material.dart';
import 'package:meals_app/meals_app/components/category_grid_item.dart';
import 'package:meals_app/meals_app/data/dummy_data.dart';
import 'package:meals_app/meals_app/models/meal.dart';
import 'package:meals_app/meals_app/screens/meals_screen.dart';

import '../models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationColtroller;

  @override
  void initState() {
    super.initState();
    _animationColtroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationColtroller.forward();
  }

  @override
  void dispose() {
    _animationColtroller.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    List<Meal> filteredMeals;

    if (category.id == 'all') {
      filteredMeals = widget.availableMeals;
    } else {
      filteredMeals =
          widget.availableMeals
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
    // final deviceHeight = MediaQuery.sizeOf(context).height;
    return AnimatedBuilder(
      animation: _animationColtroller,
      child: SafeArea(
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
      ),
      builder:
          (context, child) => SlideTransition(
            position: Tween(
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                parent: _animationColtroller,
                curve: Curves.easeInOutCubicEmphasized,
              ),
            ),
            child: child,
          ),
    );
  }
}
