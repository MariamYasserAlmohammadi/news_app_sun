import 'package:flutter/material.dart';
import 'package:news_app/ui/home/categories/categories_fragment.dart';
import 'package:news_app/modal/category_dm.dart';
import 'package:news_app/ui/home/category_details/category_details.dart';
import 'package:news_app/ui/home/home_drawer.dart';
import 'package:news_app/ui/home/settings/settings_fragment.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName="home_screen";
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    selectedWidget =CategoriesFragment(onCategoryItemClick);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage("assets/images/background_pattern.png"),fit:BoxFit.cover ),
      ),
      child: Scaffold(
        drawer: HomeDrawer(onMenuItemClick),
        appBar: AppBar(
          title: const Text('News App'),
        ),
        body: selectedWidget,
      ),
    );
  }

  late Widget selectedWidget ;

  void onMenuItemClick(MenuItem item){
    Navigator.pop(context);
    // print(item);
    switch(item){
      case MenuItem.categories :{
        selectedWidget =CategoriesFragment(onCategoryItemClick);
      }case MenuItem.settings :{
        selectedWidget =SettingsFragment();
    }
    }
    setState(() {
    });
  }

  void onCategoryItemClick(CategoryDM categoryDM){
    selectedWidget = CategoryDetails(categoryDM);
    setState(() {

    });
  }
}
