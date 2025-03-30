import 'package:flutter/material.dart';
import 'package:meals_app/meals_app/components/main_drawer.dart';
import 'package:meals_app/meals_app/data/dummy_data.dart';
import 'package:meals_app/meals_app/models/meal.dart';
import 'package:meals_app/meals_app/screens/categories_screen.dart';
import 'package:meals_app/meals_app/screens/filters_screen.dart';
import 'package:meals_app/meals_app/screens/meals_screen.dart';

const Map<Filters, bool> kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectPageIndex = 0;

  final Set<Meal> _favoriteMeals = {};

  Map<Filters, bool> _selectedFilters = kInitialFilters;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showSnackBar('Meal is No Longer Favorite');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showSnackBar('Meal is added to favorites');
    }
  }

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
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where(
      (meal) {
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
      },
    ).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    String activePageTitle = 'Categories';

    if (_selectPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals.toList(),
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Favorites';
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.set_meal,
              ),
              label: 'Categories'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Favorites',
          ),
        ],
      ),
    ));
  }
}
