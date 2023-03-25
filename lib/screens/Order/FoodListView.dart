import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_management/model/cart.dart';
import 'package:restaurant_management/model/cartHandler.dart';
import 'package:restaurant_management/model/itemList.dart';

class FoodListView extends StatelessWidget {
  const FoodListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Item> items = <Item>[
      Item(itemId: 1, name: 'FriedRice', price: 20, quantity: 1),
      Item(itemId: 2, name: 'Kottu', price: 40, quantity: 1),
      Item(itemId: 3, name: 'Rice', price: 30, quantity: 1)
    ];
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: Text(
              "Order Now",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ),
          const SizedBox(height: 20.0),
          for (Item item in items)
            ItemCard(
              item: item,
            ),
        ],
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  final Item item;
  const ItemCard({super.key, required this.item});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  List<Item> _items = [];
  List<Item> get selectedItems => _items;
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.amber[50],
        title: Container(
          width: 600,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(flex: 1),
                Text(
                  "R.S. ${widget.item.price}",
                ),
              ],
            ),
          ),
        ),
        trailing: AddtoCartButton(item: widget.item)
      ),
    );
  }
}

class AddtoCartButton extends StatefulWidget {
  final Item item;
  const AddtoCartButton({super.key,required this.item});

  @override
  State<AddtoCartButton> createState() => _AddtoCartButtonState();
}

class _AddtoCartButtonState extends State<AddtoCartButton> {
  bool _isButtonDisabled = false;

  void _disableButton() {
    context.read<CartHandler>().addItem(widget.item);

    setState(() {
      _isButtonDisabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: _isButtonDisabled ? null : _disableButton,
    );
  }
}
