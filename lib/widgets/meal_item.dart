import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal,required this.mealTapped});

  final Meal meal;
  final void Function()mealTapped;

  String get uppercaseComplexity {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get uppercaseAffordability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge, 
      elevation: 10,
      margin: EdgeInsets.all(8),

      child: InkWell(
        onTap: mealTapped,

        splashColor: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,

              child: Container(
                width: double.infinity,
                color: Colors.black54,
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: uppercaseComplexity,
                        ),
                        SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: uppercaseAffordability,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
