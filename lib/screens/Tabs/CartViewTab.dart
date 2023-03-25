import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_management/model/cartHandler.dart';
import 'package:restaurant_management/model/itemList.dart';
import 'package:restaurant_management/screens/Order/DeliveryDetails.dart';

class CartViewTab extends StatefulWidget {
  const CartViewTab({super.key});

  @override
  State<CartViewTab> createState() => _CartViewTabState();
}

class _CartViewTabState extends State<CartViewTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              child: SizedBox(
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
                            subtitle: Text(
                                // cart.getTotal.toString()
                                (item.quantity * item.price).toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => {
                                    context.read<CartHandler>().updateQuantity(
                                        item.itemId, item.quantity - 1)
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                Container(
                                  color: Colors.amber[200],
                                  child: SizedBox(
                                    width: size.width * 0.1,
                                    height: size.height * 0.05,
                                    child: Center(
                                      child: Text(
                                        item.quantity.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => {
                                    context.read<CartHandler>().updateQuantity(
                                        item.itemId, item.quantity + 1)
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                                IconButton(
                                  onPressed: () => {
                                    context.read<CartHandler>().removeItem(item)
                                  },
                                  icon: const Icon(Icons.delete),
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
        }),
        const Divider(),
        Consumer<CartHandler>(builder: (context, cart, child) {
          return Column(
            children: [
              ListTile(
                title: const Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                trailing: Text(
                  context.read<CartHandler>().getTotal.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.only(right: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DeliveryDetails()),
                        );
                      },
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        })
      ]),
    );
  }
}
