import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/meals_app/providers/meals_provider.dart';

enum Filters { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
    : super({
        Filters.glutenFree: false,
        Filters.lactoseFree: false,
        Filters.vegetarian: false,
        Filters.vegan: false,
      });

  void setFilter(Filters filters, bool isActive) {
    state = {...state, filters: isActive};
  }

  void setFilters(Map<Filters, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
      (ref) => FiltersNotifier(),
    );

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }

    if (activeFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }

    if (activeFilters[Filters.vegetarian]! && !meal.isVegetarian) {
      return false;
    }

    if (activeFilters[Filters.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
