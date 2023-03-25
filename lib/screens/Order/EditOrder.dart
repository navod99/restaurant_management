import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:restaurant_management/model/order.dart';
import 'package:restaurant_management/repositories/order_repository.dart';
import 'package:restaurant_management/screens/Common/BottomNavigatiobBar.dart';

class EditOrder extends StatefulWidget {
  final MyOrder order;
  const EditOrder({required this.order, super.key});

  @override
  State<EditOrder> createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  int _tabIndex = 0;
  int itemCount = 0;
  final _formKey = GlobalKey<FormState>();
  String? _address;
  String? _remarks;
  String? _name;
  String? _email;
  String? _mobileNo;

  void _onTapped(int index) {
    // setState(() {
    //   _tabIndex = index;
    // });
  }

  @override
  void initState() {
    super.initState();
    _address = widget.order.address;
    _name = widget.order.customerName;
    _mobileNo = widget.order.contactNo;
    _remarks = widget.order.remarks;
  }

    Future<void> _updateOrder() async {
        MyOrder order = MyOrder(
        id: widget.order.id,
        items: widget.order.items,
        total: widget.order.total,
        customerName: _name,
        address: _address,
        contactNo: _mobileNo,
        remarks: _remarks);  

    await OrderRepository().updateOrder(order);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          "Editting sucessfull",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        behavior: SnackBarBehavior.floating,
      ));

      Navigator.popUntil(context, (route) => route.isFirst == true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
        appBar: AppBar(
           backgroundColor: Color(0xFF6F35A5),
          title: const Text('Edit Order details'),
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
                            initialValue: widget.order.customerName,
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
                            initialValue: widget.order.address,
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
                            initialValue: widget.order.contactNo,
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
                            initialValue: widget.order.remarks,
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
                      onPressed: _updateOrder,
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF6F35A5))),
                      child: const Text('Edit delivery details'),
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
