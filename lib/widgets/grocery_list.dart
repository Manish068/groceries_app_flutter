import 'package:flutter/material.dart';
import 'package:groceries_app/data/models/Grocery.dart';
import 'package:groceries_app/widgets/new_item.dart';



class GroceryList extends StatefulWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<Grocery> _groceryItems = [];
  void _addItem() async {
    final newItem =
    await Navigator.of(context).push<Grocery>(MaterialPageRoute(builder: (_)=> const NewItem()));
    if(newItem==null){
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }
  
  void _removeItem(Grocery item){
      setState(() {
        _groceryItems.remove(item);
      });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text('No Items added yet.'));

    if(_groceryItems.isNotEmpty){
      content =Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView.builder(
            itemCount: _groceryItems.length,
            itemBuilder: (ctx,index){
              return Dismissible(
                key: ValueKey(_groceryItems[index].id),
                onDismissed: (direction){
                  _removeItem(_groceryItems[index]);
                },
                child: ListTile(
                  leading: Container(width: 30,height: 30,decoration: BoxDecoration(
                      color: _groceryItems[index].categories.color
                  ),),
                  title: Text(_groceryItems[index].categories.categoryName,style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground
                  ),),
                  trailing: Text(_groceryItems[index].quantity.toString()),
                ),
              );
            }),
      );
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Grocery list"),
        actions: [
          IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
        ],
      ),
      body: content,

    );
  }
}
