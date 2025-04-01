import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/meals_app/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<Set<Meal>> {
  FavoriteMealsNotifier() : super({});

  bool toggleMealFavoriteStatus(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((m) => m.id != meal.id).toSet();
      return false;
    }
    state = {...state, meal};
    return true;
  }

  bool checkFavoriteStatus(Meal meal) {
    return state.contains(meal);
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, Set<Meal>>((ref) {
      return FavoriteMealsNotifier();
    });
