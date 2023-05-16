

import 'dart:ui';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}


class Category{
   final String categoryName;
   final Color color;
   const Category(this.categoryName,this.color);
}