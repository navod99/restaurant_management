import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management/model/menu.dart';
import 'package:restaurant_management/repositories/menu_repository.dart';
// import 'package:restaurant_management/screens/Common/BottomNavigatiobBar.dart';
// import 'package:restaurant_management/screens/Menu/MenuListView.dart';
// import 'package:restaurant_management/screens/Tabs/CartViewTab.dart';

// import '../../model/cartHandler.dart';

class MenuForm extends StatefulWidget {
  final List<Menu> menuList;
  final int total;
  const MenuForm({required this.menuList, required this.total, super.key});

  @override
  State<MenuForm> createState() => _MenuFormState();
}

class _MenuFormState extends State<MenuForm> {
  final _formKey = GlobalKey<FormState>();
  late String _menuName;
  late String _mealName;
  late String _mealPrice;

  void _onTapped(int index) {
    // setState(() {
    //   _tabIndex = index;
    // });
  }

  Future<void> _addMenu() async {
    String menuId = DateTime.now().millisecondsSinceEpoch.toString();

    Menu menu = Menu (
        id: menuId,
        // menus: widget.menuList,
        // total: widget.total,
        
        menuName: _menuName,
        mealName: _mealName,
        mealPrice: _mealPrice,
        );

    await MenuRepository().addMenu(menu);

    // if (mounted) {
    //   context.read<CartHandler>().clear();
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: const Text(
    //       "Order placed sucessfully",
    //       style: TextStyle(fontWeight: FontWeight.bold),
    //     ),
    //     duration: const Duration(seconds: 3),
    //     backgroundColor: Colors.green,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //     behavior: SnackBarBehavior.floating,
    //   ));

    //   Navigator.pop(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // const List<Widget> _options = <Widget>[
    //   FoodListView(),
    //   CartViewTab(),
    //   Text('Account'),
    // ];

    return Scaffold(
        appBar: AppBar(
          title: Text('Your Menu'),
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
                                _menuName = value;
                              });
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 15.0),
                        //   child: TextFormField(
                        //     keyboardType: TextInputType.emailAddress,
                        //     cursorColor: const Color(0xFF6F35A5),
                        //     decoration: InputDecoration(
                        //         hintText: "Your Email",
                        //         border: OutlineInputBorder(
                        //             borderRadius: BorderRadius.circular(8.0))),
                        //     onChanged: (value) {
                        //       setState(() {
                        //         _menuPrice = value;
                        //       });
                        //     },
                        //   ),
                        // ),
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
                                _mealPrice = value;
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
                                _mealPrice = value;
                              });
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 15.0),
                        //   child: TextFormField(
                        //     cursorColor: const Color(0xFF6F35A5),
                        //     maxLines: 3,
                        //     decoration: InputDecoration(
                        //       hintText: "Remarks",
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(8.0),
                        //       ),
                        //     ),
                        //     onChanged: (value) {
                        //       setState(() {
                        //         _remarks = value;
                        //       });
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: size.width * 0.4,
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: _addMenu,
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
        // bottomNavigationBar: BottomNavigation(
        //     tabIndex: 0, onTabTapped: _onTapped, )
            );
 }
}