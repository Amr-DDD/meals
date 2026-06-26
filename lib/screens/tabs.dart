import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _StateTabsScreen();
  }
}

class _StateTabsScreen extends State<TabsScreen> {
  int currentScreenIndex = 0;
  final List<Meal> favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  _switchScreens(int index) {
    setState(() {
      currentScreenIndex = index;
    });
  }

  bool _isMealFavorite(Meal meal) {    
    return favoriteMeals.contains(meal);
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        favoriteMeals.add(meal);
        _showInfoMessage('Marked as a favorite!');
      });
    }
  }

  void _drawerClicked(String drawerItem) async {
    Navigator.of(context).pop();
    if (drawerItem == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
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
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget currentScreen = CategoriesScreen(
      onFavoriteTapped: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
      isFavorite: _isMealFavorite,
    );

    String screenTitle = "Categories";

    if (currentScreenIndex == 1) {
      currentScreen = MealsScreen(
        onFavoriteTapped: _toggleMealFavoriteStatus,
        meals: favoriteMeals,
        isFavorite: _isMealFavorite, 
      );
      screenTitle = "Favorites";
    }

    return Scaffold(
      appBar: AppBar(title: Text(screenTitle)),
      body: currentScreen,
      drawer: MainDrawer(drawerClicked: _drawerClicked),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _switchScreens,
        currentIndex: currentScreenIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_outlined),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
