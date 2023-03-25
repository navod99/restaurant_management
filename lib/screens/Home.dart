import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:restaurant_management/Table%20Reservation/tableReservationList.dart';
import 'package:restaurant_management/model/cart.dart';
import 'package:restaurant_management/screens/Common/BottomNavigatiobBar.dart';
import 'package:restaurant_management/screens/Login.dart';
import 'package:restaurant_management/screens/Tabs/Account.dart';
import 'package:restaurant_management/screens/Tabs/CartViewTab.dart';
import './Tabs/HomeViewTab.dart';

class Home extends StatefulWidget {
  final User? user;
  const Home(this.user, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int itemCount = 0;
  int _tabIndex = 0;
  final List<String> _tabTitles = [
    'Home',
    'Cart',
    'Account',
  ];

  static const List<Widget> _options = <Widget>[
 
    HomeViewTab(),
    CartViewTab(),
    Account(),
  ];

  void _onTapped(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // cart.loadCart();
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tabTitles[_tabIndex]),
        ),
        body: IndexedStack(
          index: _tabIndex,
          children: _options,
        ),
        bottomNavigationBar: BottomNavigation(
          tabIndex: _tabIndex,
          onTabTapped: _onTapped,
          itemCount: itemCount,
        ));
  }
}
