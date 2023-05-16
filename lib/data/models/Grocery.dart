import 'package:groceries_app/data/models/Categories.dart';

class Grocery{
  final String id;
  final String name;
  final int quantity;
  final Category categories;
  Grocery({required this.id,required this.name,required this.quantity,required this.categories});
}