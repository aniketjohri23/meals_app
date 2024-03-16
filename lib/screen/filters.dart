


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/screen/tabs.dart';
import 'package:meals_app/widdgets/main_drawer.dart';
import 'package:meals_app/providers/filters_provider.dart';




class FilterScreen extends ConsumerWidget{
  const FilterScreen({super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Your filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if(identifier== 'meals'){
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //             builder: (ctx) => const TabsScreen()
      //         ),
      //       );
      //     }
      //   },
      // ),
      // body: WillPopScope(
      //       onWillPop: () async
      //   {
      //   ref.read(filtersProvider.notifier).setFilters({
      //     Filter.glutenFree: _glutenFreeFilter,
      //     Filter.lactoseFree: _lactoseFreeFilter,
      //     Filter.Vegetarian: _vegetarianFilter,         //not needeed sincee now
      //     Filter.Vegan: _veganFilter,                      we updatee list when switched
      //   });
      //   return true;
      //
      //     },
         body: Column(children: [
          SwitchListTile(value: activeFilters[Filter.glutenFree]!,
              onChanged: (isChecked){
                ref.read(filtersProvider.notifier)
                    .setFilter(Filter.glutenFree, isChecked);
              },
          title: Text('Gluten-free',

            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color:Theme.of(context).colorScheme.onBackground
            ),),
            subtitle: Text(
              'Only include gluten free food',
              style:Theme.of(context).textTheme.labelMedium!.copyWith(
                color:Theme.of(context).colorScheme.onBackground
              )
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34,right: 22),
          ),
          SwitchListTile(value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked){
              ref.read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text('lactose-free',

              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color:Theme.of(context).colorScheme.onBackground
              ),),
            subtitle: Text(
                'Only include lactose free food',
                style:Theme.of(context).textTheme.labelMedium!.copyWith(
                    color:Theme.of(context).colorScheme.onBackground
                )
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34,right: 22),
          ),
          SwitchListTile(value: activeFilters[Filter.Vegetarian]!,
            onChanged: (isChecked){
              ref.read(filtersProvider.notifier)
                  .setFilter(Filter.Vegetarian, isChecked);
            },
            title: Text('Vegetarian',

              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color:Theme.of(context).colorScheme.onBackground
              ),),
            subtitle: Text(
                'Only include Vegetarian food',
                style:Theme.of(context).textTheme.labelMedium!.copyWith(
                    color:Theme.of(context).colorScheme.onBackground
                )
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34,right: 22),
          ),
          SwitchListTile(value: activeFilters[Filter.Vegan]!,
            onChanged: (isChecked){
              ref.read(filtersProvider.notifier)
                  .setFilter(Filter.Vegan, isChecked);
            },
            title: Text('Vegan',

              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color:Theme.of(context).colorScheme.onBackground
              ),),
            subtitle: Text(
                'Only include Vegan food',
                style:Theme.of(context).textTheme.labelMedium!.copyWith(
                    color:Theme.of(context).colorScheme.onBackground
                )
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34,right: 22),
          ),
        ],),

    );
  }







}