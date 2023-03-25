import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management/model/order.dart';
import 'package:restaurant_management/repositories/order_repository.dart';
import 'package:restaurant_management/screens/Common/BottomNavigatiobBar.dart';
import 'package:restaurant_management/screens/Order/EditOrder.dart';
import 'package:restaurant_management/screens/Order/FoodListView.dart';
import 'package:restaurant_management/screens/Order/OrderScreen.dart';
import 'package:restaurant_management/screens/Order/ViewOrder.dart';
import 'package:restaurant_management/screens/Tabs/CartViewTab.dart';

class Myorders extends StatefulWidget {
  const Myorders({super.key});

  @override
  State<Myorders> createState() => _MyordersState();
}

class _MyordersState extends State<Myorders> {
  int _tabIndex = 0;
  int itemCount = 0;

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

  Future<List<MyOrder>> _ordersFuture =
      OrderRepository().getAllOrders() as Future<List<MyOrder>>;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order History'),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "My orders",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              const SizedBox(height: 20.0),
              FutureBuilder<List<MyOrder>>(
                future: _ordersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      List<MyOrder> orders = snapshot.data ?? [];

                      return Expanded(
                        child: SizedBox(
                          width: size.width * 0.8,
                          child: ListView.builder(
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              MyOrder order = orders[index];

                              return OrderCard(order: order);
                            },
                          ),
                        ),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigation(
            tabIndex: 0, onTabTapped: _onTapped, itemCount: itemCount));
  }
}

class OrderCard extends StatefulWidget {
  final MyOrder order;
  const OrderCard({required this.order, super.key});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  List<MyOrder> _myOrder = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewOrder(
                      order: widget.order,
                    )),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
          ),
          child: ListTile(
            title: Text(
              widget.order.id,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            subtitle: Text(
              "R.S. ${widget.order.total}",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
            leading: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  EditOrder(order: widget.order,)),
                      )
                  },
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm Deletion'),
                          content: Text(
                              'Are you sure you want to cancel this order ?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No'),
                            ),
                            TextButton(
                              onPressed: () {
                                OrderRepository().deleteOrder(widget.order.id);
                               Navigator.popUntil(context, (route) => route.isFirst == true);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text(
                                    "Order cancelled sucessfully",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ));
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        );
                      },
                    )
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
