import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String id;
  String mealName;
  String mealPrice;
  String mealCategories;

  Menu({required this.id, required this.mealName, required this.mealPrice, required this.mealCategories});

  Map<String, dynamic> toMap() {
    return {'mealName': mealName, 'mealPrice': mealPrice, 'mealCategories': mealCategories,};
  }

  factory Menu.fromMap(DocumentSnapshot data) {
    return Menu(
      id: data.id,
      mealName: data['mealName'],
      mealPrice: data['mealPrice'],
      mealCategories: data['mealCategories'],
    );
  }
}