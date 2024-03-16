
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/model/meal.dart';


class FavoriteMealsNotifier extends StateNotifier<List<Meal>>{
  FavoriteMealsNotifier() : super([]);

  bool ToggleMealFavoriteStatus (Meal meal){
    final mealIsFav = state.contains(meal);

    if(mealIsFav){
      state = state.where((m) => m.id != meal.id).toList();// selects same id to remove frrom  list
      return false;
    }
    else{
      state = [...state,meal]; //else we simply add it
      return true;
    }
  }

}
final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier,List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});