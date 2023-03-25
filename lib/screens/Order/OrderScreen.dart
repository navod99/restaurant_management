import 'package:flutter/material.dart';
import 'package:restaurant_management/screens/Common/BottomNavigatiobBar.dart';
import 'package:restaurant_management/screens/Tabs/CartViewTab.dart';
import './FoodListView.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _tabIndex = 0;
  int itemCount = 0;

  static const List<Widget> _options = <Widget>[
    FoodListView(),
    CartViewTab(),
    Text('Account'),
  ];

  void _onTapped(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           backgroundColor: Color(0xFF6F35A5),
          title: const Text('Place Your Order'),
        ),
        body: IndexedStack(
          index: _tabIndex,
          children: _options,
        ),
        bottomNavigationBar: BottomNavigation(
            tabIndex: 0, onTabTapped: _onTapped, itemCount: itemCount));
  }
}
