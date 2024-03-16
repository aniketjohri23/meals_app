

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/model/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget{
  const MealDetailsScreen({
    super.key,
    required this.meal,

    });

  final Meal meal;


  @override
  Widget build(BuildContext context,WidgetRef ref) {   // reff requireddd due to consumerwiddget
    final favMeals = ref.watch(favoriteMealsProvider);
    final isFav = favMeals.contains(meal);;
    return Scaffold(
      appBar: AppBar(
      title: Text(meal.title),
        actions:[
          IconButton(onPressed: (){
            final wasAdded = ref
                .read(favoriteMealsProvider.notifier)
                .ToggleMealFavoriteStatus(meal);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(wasAdded?'meal added to favs':'meal removed'),),
            );
          }, icon:  Icon(isFav?  Icons.star:Icons.star_border))
        ]
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
          meal.imageUrl,
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
          ),
          const SizedBox(height:14),
           Text(
            'Ingredients',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 14,),
          for(final ingreddient in meal.ingredients)
            Text(
              ingreddient,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          Text(
            'Ingredients',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),),
      
          for(final step in meal.steps)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              child: Text(
                step,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,

                ),
              ),
            ),
      
      
      
        ],
      ),
    ),
    );

  }

}