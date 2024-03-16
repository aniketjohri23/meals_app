
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/screen/CategoriesScreen.dart';
import 'package:meals_app/screen/meals.dart';
import 'package:meals_app/widdgets/main_drawer.dart';
import 'package:meals_app/providers/filters_provider.dart';
import '../model/meal.dart';
import 'filters.dart';

const kInitialFilter = {
  Filter.glutenFree : false,
  Filter.lactoseFree: false,
  Filter.Vegetarian: false,
  Filter.Vegan: false

};

class TabsScreen extends ConsumerStatefulWidget{
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }

}




class _TabsScreenState extends ConsumerState<TabsScreen>{
  int _selectedPageIndex = 0;

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if(identifier == 'filters'){

       Navigator.of(context).push<Map<Filter,bool>>(  //wait ffor value to update
      MaterialPageRoute(
        builder: (ctx)=> const FilterScreen()
      )
      );

    }


  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals =ref.watch(filteredMealsProvider);


    Widget activeScreen =  CategoriesScreen(

      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';


    if(_selectedPageIndex == 1) {
      final favMeals = ref.watch(favoriteMealsProvider);
      activeScreen =  MealsScreen(
        title: "Favorites",
        meals: favMeals,
        );
      activePageTitle = 'favorites';
    }

    return Scaffold(
      appBar:AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen:_setScreen ,),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: ' Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star),label: 'Favorites'),

        ],
      ),

    );

  }
}