import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:restaurant_management/screens/Login.dart';
import './Tabs/HomeViewTab.dart';

class Home extends StatefulWidget {
  final User? user;
  const Home(this.user, {super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _tabIndex = 0;
  final List<String> _tabTitles = [
    'Home',
    'Cart',
    'Account',
  ];

  static const List<Widget> _options = <Widget>[
    HomeViewTab(),
    Text('Cart'),
    Text('Account'),
  ];

  void _onTapped(int index) {
    setState(() {
      _tabIndex = index;
    });
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF6F35A5),
        selectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _tabIndex,
        onTap: _onTapped,
      ),
    );
  }
}
