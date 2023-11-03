import 'package:flutter/material.dart';

class CategoryDM{
  String id;
  String title;
  Color color;
  String imageName;

  CategoryDM(this.id,this.title,this.imageName,this.color);
  static List<CategoryDM> getAllCategories(){
    return[
      CategoryDM('sports', 'Sports', 'sports.png', const Color(0xFFC91C22)),
      CategoryDM('general', 'General', 'general.png', const Color(0xFF003E90)),
      CategoryDM('health', 'Health', 'health.png', const Color(0xFFED1E79)),
      CategoryDM('business', 'Business', 'business.png', const Color(0xFFCF7E48)),
      CategoryDM('technology', 'Technology', 'technology.png', const Color(0xFFC91C22)),
      CategoryDM('science', 'Science', 'science.png', const Color(0xFFF2D352)),
    ];
  }

}