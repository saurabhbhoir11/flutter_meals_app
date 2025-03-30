import 'package:flutter/material.dart';

class FiltersSettingsTile extends StatefulWidget {
  const FiltersSettingsTile({
    super.key,
    required this.isFilterSet,
    required this.changeFilterState,
    required this.titleText,
    required this.subTitleText,
  });

  final bool isFilterSet;
  final void Function(bool) changeFilterState;
  final String titleText;
  final String subTitleText;

  @override
  State<FiltersSettingsTile> createState() {
    return _FiltersScreenTileState();
  }
}

class _FiltersScreenTileState extends State<FiltersSettingsTile> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: widget.isFilterSet,
      onChanged: (isChecked) {
        widget.changeFilterState(isChecked);
      },
      title: Text(
        widget.titleText,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      subtitle: Text(
        widget.subTitleText,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(
        left: 35,
        right: 25,
      ),
    );
  }
}
