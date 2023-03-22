import 'package:flutter/material.dart';
import 'package:restaurant_management/screens/Common/BottomNavigatiobBar.dart';
import './FoodListView.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
   int _tabIndex = 0;


  static const List<Widget> _options = <Widget>[
    FoodListView(),
    Text('Cart'),
    Text('Account'),
  ];

  void _onTapped(int index) {
    setState(() {
      _tabIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text('HIII'),
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: _options,
      ),
      bottomNavigationBar: BottomNavigation(
        tabIndex: 0,
        onTabTapped: _onTapped
      )
    );
  }
}