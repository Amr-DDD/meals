import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onFavoriteTapped,
    required this.isFavorite,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal) onFavoriteTapped;
  final bool Function(Meal) isFavorite;

  void _switchScreen(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => MealDetailsScreen(
          onFavoriteTapped: onFavoriteTapped,
          meal: meal,
          isFavorite: isFavorite(meal),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        "Uh oh ... nothing here!",
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          mealTapped: () {
            _switchScreen(context, meals[index]);
          },
        ),
        itemCount: meals.length,
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
