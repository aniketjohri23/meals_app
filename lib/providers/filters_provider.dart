import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter{
  glutenFree,
  lactoseFree,
  Vegetarian,
  Vegan
}

class FiltersNotifier extends StateNotifier<Map<Filter,bool>>{
  FiltersNotifier() : super({
    Filter.glutenFree : false,
    Filter.lactoseFree : false,
    Filter.Vegetarian : false,
    Filter.Vegan : false
  });

  void setFilters(Map<Filter,bool>chosen){
    state =chosen;
  }
  void setFilter(Filter filter,bool isActive){
    state = {
      ...state,
      filter: isActive,
    };
  }

}

final filtersProvider = StateNotifierProvider<FiltersNotifier,Map<Filter,bool>>(
        (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal){
    if(activeFilters[Filter.glutenFree]! && !meal.isGlutenFree){
      return false;
    }
    if(activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
      return false;
    }
    if(activeFilters[Filter.Vegan]! && !meal.isVegan){
      return false;
    }
    if(activeFilters[Filter.Vegetarian]! && !meal.isVegetarian){
      return false;
    }
    return true;

  }).toList();
});




