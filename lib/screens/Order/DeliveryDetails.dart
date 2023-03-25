import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_management/model/cartHandler.dart';
import 'package:restaurant_management/model/itemList.dart';
import 'package:restaurant_management/screens/Common/BottomNavigatiobBar.dart';
import 'package:restaurant_management/screens/Order/DeliveryForm.dart';
import 'package:restaurant_management/screens/Order/FoodListView.dart';
import 'package:restaurant_management/screens/Tabs/CartViewTab.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({super.key});

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  int _tabIndex = 0;
  int itemCount = 0;
  final _formKey = GlobalKey<FormState>();
  late String _password;
  late String _name;
  late String _email;

  static const List<Widget> _options = <Widget>[
    FoodListView(),
    CartViewTab(),
    Text('Account'),
  ];

  void _onTapped(int index) {
    // setState(() {
    //   _tabIndex = index;
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
           backgroundColor: Color(0xFF6F35A5),
          title: Text('Place Your Order'),
        ),
        body: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer<CartHandler>(builder: (context, cart, child) {
                    List<Item> itemList = cart.items;
                    child:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DataTable(
                            columns: const [
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Quantity')),
                              DataColumn(label: Text('Price')),
                            ],
                            rows: itemList.map((item) {
                              return DataRow(cells: [
                                DataCell(Text(item.name)),
                                DataCell(Text(
                                    (item.price * item.quantity).toString())),
                                DataCell(Text(item.quantity.toString())),
                              ]);
                            }).toList(),
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  "Total",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                Text(
                                  "R.S. ${context.read<CartHandler>().getTotal.toString()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                              ],
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
                                          builder: (context) =>
                                               DeliveryForm(itemList: itemList, total: context.read<CartHandler>().getTotal)),
                                    );
                                  },
                                  child: const Text('Next'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
            tabIndex: 0, onTabTapped: _onTapped, itemCount: itemCount));
  }
}
