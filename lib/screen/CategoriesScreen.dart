
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screen/meals.dart';
import 'package:meals_app/widdgets/category_grid_item.dart';
import 'package:meals_app/model/Category.dart';
import 'package:meals_app/widdgets/meals_scoll_view.dart';

import '../model/meal.dart';







class CategoriesScreen extends StatefulWidget{

  const CategoriesScreen ({super.key, required this.availableMeals});


  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  ScrollController _scrollController = ScrollController();

  @override
  void initState(){

    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1
    );

    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double minScr = _scrollController.position.minScrollExtent;
      double maxScr = _scrollController.position.maxScrollExtent;

      animatetoMaxMin(minScr,maxScr,maxScr,5,_scrollController);
    });

  }


  animatetoMaxMin(double minScr,double maxScr,double dirn,int dur,ScrollController scrollController){
      scrollController.animateTo(
          dirn,
          duration: Duration(seconds: dur),
          curve: Curves.linear)
      .then((value){
        dirn = dirn == maxScr? minScr:maxScr;
        animatetoMaxMin(maxScr, minScr, dirn, dur, scrollController);
      }
      );

  }

  @override
  void dispose(){
    _scrollController.dispose();
    _animationController.dispose();      //to avoid memory overflows
    super.dispose();
  }

  void _selectCategory(BuildContext context , Category category){

    final filteredMeals = widget.availableMeals.
        where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => MealsScreen(
              title: category.title,
              meals: filteredMeals,

          ),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: ( context, child)  =>SlideTransition(
                  position: Tween(
                    begin: const Offset(0,0.3),
                    end: const Offset(0,0),
                  )
                      .animate(CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.easeInOut)),

                  child: child,
                ),
      child: Container(
        child: ListView(
          children: [

            MealsListView(
                images: ScrollImage,
                scrollController: _scrollController),

        GridView.count(
                    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3/2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      shrinkWrap :true,
                    children: [
                      for(final category in availableCategories)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: CategoryGridItem(
                            category: category,
                            onSelectCategory: (){
                              _selectCategory(context,category);
                            },
                          ),
                        )
                    ],
                  )

          ],
        ),
      ),
    );

  }
}


