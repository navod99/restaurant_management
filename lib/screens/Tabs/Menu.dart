import 'package:flutter/material.dart';

class FoodMenuList extends StatelessWidget {
  final List<String> items = [
    'Pizza',
    'Burger',
    'Tacos',
    'Sushi',
    'Fried Chicken',
    'Pasta',
    'Salad',
    'Soup',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Menu'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.restaurant_menu),
              title: Text(items[index]),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                // Navigate to item details screen
              },
            ),
          );
        },
      ),
    );
  }
}