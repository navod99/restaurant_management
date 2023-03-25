import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management/model/menu.dart';
import 'package:restaurant_management/repositories/menu_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:restaurant_management/screens/Common/BottomNavigatiobBar.dart';
// import 'package:restaurant_management/screens/Menu/MenuListView.dart';
// import 'package:restaurant_management/screens/Tabs/CartViewTab.dart';

// import '../../model/cartHandler.dart';

class MenuForm extends StatefulWidget {
  const MenuForm({super.key});

  @override
  State<MenuForm> createState() => _MenuFormState();
}

class _MenuFormState extends State<MenuForm> {
  final _formKey = GlobalKey<FormState>();
  String? _menuName;
  String? _mealName;
  String? _mealPrice;

  void _onTapped(int index) {
    // setState(() {
    //   _tabIndex = index;
    // });
  }

  Future<void> _addMenu() async {
    String menuId = DateTime.now().millisecondsSinceEpoch.toString();

    // Menu menu = Menu (
    //     id: menuId,
    //     // menus: widget.menuList,
    //     // total: widget.total,
        
    //     menuName: _menuName,
    //     mealName: _mealName,
    //     mealPrice: _mealPrice,
    //     );

  //  await MenuRepository().addMenu(menu);

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
          title: Text('Menu'),
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
                    "Menu Details",
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
                            decoration: InputDecoration(
                              hintText: "Price",
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
                            cursorColor: Color.fromARGB(255, 83, 60, 2),
                            decoration: InputDecoration(
                              hintText: "Category",
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
                      onPressed: (){
                            FirebaseFirestore.instance
                      .collection('Menu')
                      .add(<String, dynamic>{
                    'Name': _menuName,
                    'Meal Name': _mealName,
                    'Price': _mealPrice,
                    
                  });
                  if (mounted) {
                    
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(children: [
                        Icon(Icons.check),
                        const Text(
                          "Menu Added Successfully",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ]),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      behavior: SnackBarBehavior.floating,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Row(children: [
                        const Icon(Icons.warning_rounded),
                        const Text(
                          "somthing went wrong!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                      duration: const Duration(seconds: 3),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      behavior: SnackBarBehavior.floating,
                    ));
                  }
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 241, 160, 38))),
                      child: const Text('Submit'),
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