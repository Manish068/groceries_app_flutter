import '../models/Categories.dart';
import '../models/Grocery.dart';
import 'categories_item.dart';

final groceryItems=[
  Grocery(id: 'a',name: "Milk",quantity: 1, categories: categories[Categories.dairy]!),
  Grocery(id: 'b',name: "Bananas",quantity: 5, categories: categories[Categories.fruit]!),
  Grocery(id: 'c',name: "Beef Steak",quantity: 1, categories: categories[Categories.meat]!),
  Grocery(id: 'c',name: "lady finger",quantity: 1, categories: categories[Categories.vegetables]!),
];