import 'package:flutter/material.dart';

enum Filter { glutenFree, lactoseFree, vegetarian }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isLactoseFree = false;
  bool _isGlutenFree = false;
  bool _vegetarian = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFree = widget.currentFilters[Filter.glutenFree]!;
    _isLactoseFree = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarian = widget.currentFilters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose your Filters")),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic result) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _isGlutenFree,
            Filter.lactoseFree: _isLactoseFree,
            Filter.vegetarian: _vegetarian,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _isLactoseFree,
              onChanged: (onChanged) {
                setState(() {
                  _isLactoseFree = onChanged;
                });
              },
              title: Text("Lactose-Free"),
              subtitle: Text("Only include lactose free meals"),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),

            SwitchListTile(
              value: _isGlutenFree,
              onChanged: (onChanged) {
                setState(() {
                  _isGlutenFree = onChanged;
                });
              },
              title: Text("Gluten-Free"),
              subtitle: Text("Only include gluten free meals"),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),

            SwitchListTile(
              value: _vegetarian,
              onChanged: (onChanged) {
                setState(() {
                  _vegetarian = onChanged;
                });
              },
              title: Text("Vegetarian"),
              subtitle: Text("Only include vegetarian meals"),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
