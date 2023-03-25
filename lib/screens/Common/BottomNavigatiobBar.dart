import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_management/model/cartHandler.dart';
import 'package:restaurant_management/model/itemList.dart';

class BottomNavigation extends StatefulWidget {
  List<Item> cartItems = [];
  final int tabIndex;
  final ValueChanged<int> onTabTapped;
  final int itemCount;
  BottomNavigation(
      {required this.tabIndex,
      required this.onTabTapped,
      required this.itemCount,
      super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.tabIndex,
      onTap: widget.onTabTapped,
      backgroundColor: const Color(0xFF6F35A5),
      selectedItemColor: Colors.white,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Consumer<CartHandler>(builder: (context, cart, child) {
            return Stack(
              children: [
                const Icon(Icons.shopping_cart),
                Positioned(
                  top: 0,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      cart.itemCount.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
    );
  }
}
