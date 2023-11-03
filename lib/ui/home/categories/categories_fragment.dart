import 'package:flutter/material.dart';
import 'package:news_app/modal/category_dm.dart';
import 'package:news_app/ui/home/categories/category_widget.dart';

typedef OnCategoryClick = void Function(CategoryDM categoryDM);
class CategoriesFragment extends StatelessWidget {
  OnCategoryClick onCategoryClick;
List<CategoryDM> categories =CategoryDM.getAllCategories();

  CategoriesFragment(this.onCategoryClick ,{super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Pick Your Category \n of interest'
            ,style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
          ),),
          Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 20,),
            itemBuilder:(context,index) => InkWell(
                onTap: (){
                  onCategoryClick(categories[index]);
                },
                child: CategoryItem(categories[index],index)),
            itemCount:categories.length ,),
          ),

        ],
      ),
    );
  }
}
