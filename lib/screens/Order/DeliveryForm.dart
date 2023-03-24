import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_management/model/itemList.dart';
import 'package:restaurant_management/model/order.dart';
import 'package:restaurant_management/repositories/order_repository.dart';
import 'package:restaurant_management/screens/Common/BottomNavigatiobBar.dart';
import 'package:restaurant_management/screens/Order/FoodListView.dart';
import 'package:restaurant_management/screens/Tabs/CartViewTab.dart';

import '../../model/cartHandler.dart';

class DeliveryForm extends StatefulWidget {
  final List<Item> itemList;
  final int total;
  const DeliveryForm({required this.itemList, required this.total, super.key});

  @override
  State<DeliveryForm> createState() => _DeliveryFormState();
}

class _DeliveryFormState extends State<DeliveryForm> {
  int _tabIndex = 0;
  int itemCount = 0;
  final _formKey = GlobalKey<FormState>();
  late String _address;
  late String _remarks;
  late String _name;
  late String _email;
  late String _mobileNo;

  void _onTapped(int index) {
    // setState(() {
    //   _tabIndex = index;
    // });
  }

  Future<void> _placeOrder() async {
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    MyOrder order = MyOrder(
        id: orderId,
        items: widget.itemList,
        total: widget.total,
        customerName: _name,
        address: _address,
        contactNo: _mobileNo,
        remarks: _remarks);

    await OrderRepository().addOrder(order);

    if (mounted) {
      context.read<CartHandler>().clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          "Order placed sucessfully",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ));

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    const List<Widget> _options = <Widget>[
      FoodListView(),
      CartViewTab(),
      Text('Account'),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text('Place Your Order'),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: size.width * 0.9,
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "Delivery details",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            cursorColor: const Color(0xFF6F35A5),
                            decoration: InputDecoration(
                                hintText: "Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                            onChanged: (value) {
                              setState(() {
                                _name = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: const Color(0xFF6F35A5),
                            decoration: InputDecoration(
                                hintText: "Your Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: TextFormField(
                            cursorColor: const Color(0xFF6F35A5),
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: "Address",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _address = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: TextFormField(
                            cursorColor: const Color(0xFF6F35A5),
                            decoration: InputDecoration(
                              hintText: "Contact No",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _mobileNo = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: TextFormField(
                            cursorColor: const Color(0xFF6F35A5),
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: "Remarks",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _remarks = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: size.width * 0.4,
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: _placeOrder,
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF6F35A5))),
                      child: const Text('Place Order'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigation(
            tabIndex: 0, onTabTapped: _onTapped, itemCount: itemCount));
  }
}
