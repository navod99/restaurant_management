// import 'dart:convert';

// import 'package:restaurant_management/model/itemList.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Cart {
//   List<Item> items = [];
//   int itemCount = 0;

//   static final Cart _singleton = Cart._internal();

//   factory Cart() {
//     return _singleton;
//   }

//   Cart._internal();

//   Future<void> loadCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartData = prefs.getString('cart');
//     if (cartData != null) {
//       final List<dynamic> itemList = jsonDecode(cartData);
//       items = itemList.map((item) => Item.fromJson(item)).toList();
//       itemCount = items.length;
//     }
//   }

//   Future<void> saveCart() async {
//     final prefs = await SharedPreferences.getInstance();
//     final cartData = jsonEncode(items.map((item) => item.toJson()).toList());
//     await prefs.setString('cart', cartData);
//     itemCount = items.length;
//   }

//   void addItem(Item item) {
//     items.add(item);
//     saveCart();
//   }

//   void removeItem(Item item) {
//     items.remove(item);
//     saveCart();
//   }
  
//   int getCartItemCount() {
//     return itemCount;
//   }
// }