import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String id;
  String menuName;
  String mealName;
  String mealPrice;

  Menu({required this.id, required this.menuName, required this.mealName, required this.mealPrice});

  Map<String, dynamic> toMap() {
    return {'menuName':menuName,'mealName': mealName, 'mealPrice': mealPrice, };
  }

  factory Menu.fromMap(DocumentSnapshot data) {
    return Menu(
      id: data.id,
      menuName: data['menuName'],
      mealName: data['mealName'],
      mealPrice: data['mealPrice'],
    );
  }
}