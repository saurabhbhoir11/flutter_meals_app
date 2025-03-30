import 'package:flutter/material.dart';
import 'package:meals_app/meals_app/components/filters_settings_tile.dart';
// import 'package:meals_app/meals_app/components/main_drawer.dart';
// import 'package:meals_app/meals_app/screens/tabs_screen.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });

  final Map<Filters, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilterSet = false;
  bool _lactoseFreeFilterSet = false;
  bool _vegetarianFilterSet = false;
  bool _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filters.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filters.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filters.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filters.vegan]!;
  }

  bool get isGluetenFreeChecked {
    return _glutenFreeFilterSet;
  }

  void changeGluetenFreeFilter(bool isGluetenFreeFilterSet) {
    setState(() {
      _glutenFreeFilterSet = isGluetenFreeFilterSet;
    });
  }

  bool get isLactoseFreeChecked {
    return _lactoseFreeFilterSet;
  }

  void changeLactoseFreeFilter(bool isLactoseFreeFilterSet) {
    setState(() {
      _lactoseFreeFilterSet = isLactoseFreeFilterSet;
    });
  }

  bool get isVegetarianFilterChecked {
    return _vegetarianFilterSet;
  }

  void changeVegetarianFilter(bool isVegetarianFilterSet) {
    setState(() {
      _vegetarianFilterSet = isVegetarianFilterSet;
    });
  }

  bool get isVeganFilterChecked {
    return _veganFilterSet;
  }

  void changeVeganFilter(bool isVeganFilterSet) {
    setState(() {
      _veganFilterSet = isVeganFilterSet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
        ),
        // drawer: MainDrawer(onSelectScreen: (identifier) {
        //   Navigator.of(context).pop();
        //   if (identifier == 'meals') {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (ctx) => const TabsScreen(),
        //       ),
        //     );
        //   }
        // }),
        body: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, dynamic result) {
            if (didPop) return;
            Navigator.of(context).pop(
              {
                Filters.glutenFree: _glutenFreeFilterSet,
                Filters.lactoseFree: _lactoseFreeFilterSet,
                Filters.vegetarian: _vegetarianFilterSet,
                Filters.vegan: _veganFilterSet,
              },
            );
          },
          child: Column(
            children: [
              FiltersSettingsTile(
                isFilterSet: isGluetenFreeChecked,
                changeFilterState: changeGluetenFreeFilter,
                titleText: 'Gluten-Free',
                subTitleText: 'Only Include Gluten-Free Meals',
              ),
              FiltersSettingsTile(
                isFilterSet: isLactoseFreeChecked,
                changeFilterState: changeLactoseFreeFilter,
                titleText: 'Lactose-Free',
                subTitleText: 'Only Include Lactose-Free Meals',
              ),
              FiltersSettingsTile(
                isFilterSet: isVegetarianFilterChecked,
                changeFilterState: changeVegetarianFilter,
                titleText: 'Vegetarian',
                subTitleText: 'Only Include Vegetarian Meals',
              ),
              FiltersSettingsTile(
                isFilterSet: isVeganFilterChecked,
                changeFilterState: changeVeganFilter,
                titleText: 'Vegan',
                subTitleText: 'Only Include Vegan Meals',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
