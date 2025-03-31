import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/meals_app/models/meal.dart';
import 'package:meals_app/meals_app/providers/favorites_provider.dart';

class FavoriteIcon extends ConsumerStatefulWidget {
  const FavoriteIcon({super.key, required this.meal});

  final Meal meal;

  @override
  ConsumerState<FavoriteIcon> createState() {
    return FavoriteIconState();
  }
}

class FavoriteIconState extends ConsumerState<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    final bool isFavorite = ref
        .read(favoriteMealsProvider.notifier)
        .checkFavoriteStatus(widget.meal);
    Color iconColor = Colors.white;
    if (isFavorite) {
      iconColor = Color.fromARGB(255, 255, 215, 0);
    } else {
      iconColor = Colors.white;
    }
    return Icon(Icons.star, color: iconColor);
  }
}
