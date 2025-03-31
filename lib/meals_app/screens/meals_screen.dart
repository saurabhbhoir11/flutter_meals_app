import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/meals_app/components/meal_item.dart';
import 'package:meals_app/meals_app/models/meal.dart';
import 'package:meals_app/meals_app/providers/favorites_provider.dart';
import 'package:meals_app/meals_app/screens/meal_details_screen.dart';

class MealsScreen extends ConsumerWidget {
  const MealsScreen({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => MealDetailsScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content;

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh Oh!... Nothing Here',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Try Selecting A Different Category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    } else {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder:
            (ctx, index) => MealItem(
              meal: meals[index],
              onSelectMeal: (meal) {
                selectMeal(context, meal);
              },
              onToggleFavorite:
                  ref
                      .read(favoriteMealsProvider.notifier)
                      .toggleMealFavoriteStatus,
            ),
      );
    }

    if (title == null) {
      return content;
    }

    return SafeArea(
      child: Scaffold(appBar: AppBar(title: Text(title!)), body: content),
    );
  }
}
