import 'package:flutter/material.dart';
import 'package:meals_app/meals_app/components/filters_settings_tile.dart';
import 'package:meals_app/meals_app/providers/filters_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Your Filters')),
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
        body:
        // PopScope(
        //   canPop: false,
        //   onPopInvokedWithResult: (bool didPop, dynamic result) {
        //     ref.read(filtersProvider.notifier).setFilters(
        //       {
        //         Filters.glutenFree: _glutenFreeFilterSet,
        //         Filters.lactoseFree: _lactoseFreeFilterSet,
        //         Filters.vegetarian: _vegetarianFilterSet,
        //         Filters.vegan: _veganFilterSet,
        //       },
        //     );
        //     if (didPop) return;
        //     Navigator.of(context).pop();
        //     // return;
        //   },
        //   child:
        Column(
          children: [
            FiltersSettingsTile(
              isFilterSet: activeFilters[Filters.glutenFree]!,
              changeFilterState: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filters.glutenFree, isChecked);
              },
              titleText: 'Gluten-Free',
              subTitleText: 'Only Include Gluten-Free Meals',
            ),
            FiltersSettingsTile(
              isFilterSet: activeFilters[Filters.lactoseFree]!,
              changeFilterState: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filters.lactoseFree, isChecked);
              },
              titleText: 'Lactose-Free',
              subTitleText: 'Only Include Lactose-Free Meals',
            ),
            FiltersSettingsTile(
              isFilterSet: activeFilters[Filters.vegetarian]!,
              changeFilterState: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filters.vegetarian, isChecked);
              },
              titleText: 'Vegetarian',
              subTitleText: 'Only Include Vegetarian Meals',
            ),
            FiltersSettingsTile(
              isFilterSet: activeFilters[Filters.vegan]!,
              changeFilterState: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filters.vegan, isChecked);
              },
              titleText: 'Vegan',
              subTitleText: 'Only Include Vegan Meals',
            ),
          ],
        ),
      ),
    );
  }
}
