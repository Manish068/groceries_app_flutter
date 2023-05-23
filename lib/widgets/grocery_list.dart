import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:groceries_app/data/models/Grocery.dart';
import 'package:groceries_app/widgets/new_item.dart';
import 'package:http/http.dart' as http;

import '../data/dummy/categories_item.dart';



class GroceryList extends StatefulWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
   List<Grocery> _groceryItems = [];
   var isLoading = true;
   String? _error;
  @override
  void initState() {
    _loadItems();
    super.initState();
  }

  void _loadItems() async {
    final url = Uri.https("grocery-app-dc9d2-default-rtdb.firebaseio.com",
        'Shopping-list.json');

    final response = await http.get(url, headers: {
      'Content-type': 'application/json',
    });

    if(response.statusCode >=400) {
      setState(() {
        _error = "Failed to fetch data. Please try again later.";
      });

    }

    if(response.body == 'null'){
      setState(() {
        isLoading=false;
      });
      return;
    }




    final Map<String,dynamic> listData = json.decode(response.body);
    final List<Grocery> _loadedItems =[];
    for(final item in listData.entries){
      final category = categories.entries.firstWhere((category) => category.value.categoryName == item.value['category']).value;
      _loadedItems.add(Grocery(id: item.key, name: item.value['name'], quantity: item.value['quantity'], categories: category));
    }

    setState(() {
      _groceryItems = _loadedItems;
      isLoading=false;
    });
  }

  void _addItem() async {
    final url = Uri.https("grocery-app-dc9d2-default-rtdb.firebaseio.com",
        'Shopping-list.json');

    final response = await http.get(url, headers: {
      'Content-type': 'application/json',
    });

    final newItem =await Navigator.of(context).push<Grocery>(MaterialPageRoute(builder: (_)=> const NewItem())) as Grocery;
    setState(() {
      _groceryItems.add(newItem);
    });


  }
  
  void _removeItem(Grocery item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    final url = Uri.https("grocery-app-dc9d2-default-rtdb.firebaseio.com",
        'Shopping-list/${item.id}.json');

    final response = await http.delete(url);

    if(response.statusCode>400){
      setState(() {
        _groceryItems.insert(index,item);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(child: Text('No Items added yet.'));

    if(isLoading){
      content = const Center(child: CircularProgressIndicator(),);
    }

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
                  title: Text(_groceryItems[index].name,style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground
                  ),),
                  trailing: Text(_groceryItems[index].quantity.toString()),
                ),
              );
            }),
      );
    }

    if(_error!=null){
       content = Center(child: Text(_error!));
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
