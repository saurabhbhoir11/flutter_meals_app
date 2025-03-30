import 'package:flutter/material.dart';

enum Complexity {
  simple,
  chalenging,
  hard,
}

enum Affordability {
  affordable,
  pricy,
  luxurious,
}

class Meal {
  Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.image,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });

  final String id;
  final List<String> categories;
  final String title;
  final AssetImage image;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
}
