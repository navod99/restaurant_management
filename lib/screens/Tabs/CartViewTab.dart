import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_management/model/cartHandler.dart';
import 'package:restaurant_management/model/itemList.dart';

class CartViewTab extends StatefulWidget {
  const CartViewTab({super.key});

  @override
  State<CartViewTab> createState() => _CartViewTabState();
}

class _CartViewTabState extends State<CartViewTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Consumer<CartHandler>(builder: (context, cart, child) {
          if (cart.itemCount < 1) {
            return const Center(
              child: Text(
                "Your cart is empty",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            );
          } else {
            return Expanded(
              child: SizedBox
              (
                height: 300,
                child: ListView.builder(
                  itemCount: cart.itemCount,
                  itemBuilder: (context, index) {
                    Item item = cart.items[index];
                    return Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: Text(item.name),
                            subtitle: Text(item.price.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => {},
                                  icon: Icon(Icons.add),
                                ),
                                IconButton(
                                  onPressed: () => {},
                                  icon: Icon(Icons.remove),
                                ),
                                IconButton(
                                  onPressed: () => {
                                    
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          }
        })
      ]),
    );
  }
}
