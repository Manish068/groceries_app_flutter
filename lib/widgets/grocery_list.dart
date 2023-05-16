import 'package:flutter/material.dart';

import '../data/dummy/groceries_item.dart';


class GroceryList extends StatelessWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Grocery list"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView.builder(
            itemCount: groceryItems.length,
            itemBuilder: (ctx,index){
              return ListTile(
                leading: Container(width: 30,height: 30,decoration: BoxDecoration(
                    color: groceryItems[index].categories.color
                ),),
                title: Text(groceryItems[index].categories.categoryName,style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),),
                trailing: Text(groceryItems[index].quantity.toString()),
              );
            }),
      ),

    );
  }
}
