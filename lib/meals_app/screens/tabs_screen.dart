import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/meals_app/components/main_drawer.dart';
import 'package:meals_app/meals_app/providers/favorites_provider.dart';
import 'package:meals_app/meals_app/screens/categories_screen.dart';
import 'package:meals_app/meals_app/screens/filters_screen.dart';
import 'package:meals_app/meals_app/screens/meals_screen.dart';
import 'package:meals_app/meals_app/providers/meals_provider.dart';

const Map<Filters, bool> kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectPageIndex = 0;

  Map<Filters, bool> _selectedFilters = kInitialFilters;

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals =
        meals.where((meal) {
          if (_selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }

          if (_selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }

          if (_selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) {
            return false;
          }

          if (_selectedFilters[Filters.vegan]! && !meal.isVegan) {
            return false;
          }

          return true;
        }).toList();

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    String activePageTitle = 'Categories';

    if (_selectPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(meals: favoriteMeals.toList());
      activePageTitle = 'Favorites';
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(activePageTitle)),
        drawer: MainDrawer(onSelectScreen: _setScreen),
        body: activePage,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
          ],
        ),
      ),
    );
  }
}
