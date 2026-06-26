import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onFavoriteTapped,
    required this.availableMeals,
    required this.isFavorite,
  });
  
  final void Function(Meal) onFavoriteTapped;
  final List<Meal> availableMeals;
final bool Function(Meal) isFavorite;


  void _switchScreen(BuildContext context, Category category) {
    final filteredMeals = availableMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          onFavoriteTapped: onFavoriteTapped,
          title: category.title,
          meals: filteredMeals,
          isFavorite: isFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            gridItem: category,
            onScreenTap: () {
              _switchScreen(context, category);
            },
          ),
      ],
    );
  }
}
