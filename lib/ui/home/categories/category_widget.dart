import 'package:flutter/material.dart';

import '../../../modal/category_dm.dart';

class CategoryItem extends StatelessWidget {
  CategoryDM categoryDM;
  int index;
  CategoryItem(this.categoryDM ,this.index,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: categoryDM.color,
        borderRadius: BorderRadius.only(
         topRight: const Radius.circular(24),
            topLeft: const Radius.circular(24),
            bottomLeft:Radius.circular(index.isEven ?24:0),
            bottomRight:Radius.circular(index.isEven ?0:24),
        )
      ),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset('assets/images/${categoryDM.imageName}',
            height: 120,
          width: double.infinity,
          fit: BoxFit.fitHeight,),
          Text(categoryDM.title,style: const TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),),
        ],
      ),
    );
  }
}
