import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealsListView extends StatelessWidget{

   final ScrollController scrollController;
  final List images;

   MealsListView({super.key,required this.images, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView.builder(
        controller: scrollController,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: images.length,
          itemBuilder: (ctx,index){
          return Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    images[index],
                    width: 150,
                    fit: BoxFit.cover,
                
                ),
              ),
          );
          }
      ),
    );
  }


}