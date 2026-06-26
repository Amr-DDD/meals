import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoryGridItem extends StatelessWidget {
  final Category gridItem;
  final void Function() onScreenTap;
  const CategoryGridItem({
    super.key,
    required this.gridItem,
    required this.onScreenTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onScreenTap,
      
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              gridItem.color.withAlpha(125),
              gridItem.color.withAlpha(235),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft
          ),
        ),
        child: Text(
          gridItem.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
