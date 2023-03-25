import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:restaurant_management/model/itemList.dart';
import 'package:restaurant_management/model/order.dart';
import 'package:restaurant_management/screens/Common/BottomNavigatiobBar.dart';
import 'package:restaurant_management/screens/Order/FoodListView.dart';
import 'package:restaurant_management/screens/Tabs/CartViewTab.dart';
import 'package:flutter/material.dart';

class ViewOrder extends StatefulWidget {
  final MyOrder order;

  const ViewOrder({required this.order, super.key});

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
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
    List<Item> itemList = widget.order.items;
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
                  Center(
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
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text(
                                    "Total",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                  Text(
                                    widget.order.total.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(64.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Name:',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.order.customerName.toString(),
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      const Text(
                                        'Contact Number:',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.order.contactNo.toString(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      const Text(
                                        'Address:',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        widget.order.customerName.toString(),
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(
            tabIndex: 0, onTabTapped: _onTapped, itemCount: itemCount));
  }
}
