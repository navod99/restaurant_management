import 'package:flutter/material.dart';
import 'package:restaurant_management/model/itemList.dart';

class CartHandler extends ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  int get itemCount => _items.length;
  int get getTotal => _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(Item item) {
    _items.remove(item);
    notifyListeners();
  }

  void updateQuantity(num id, int quantity){
    int index = _items.indexWhere((item) => item.id == id);

    if(index >=0){
      _items[index].quantity = quantity;
      notifyListeners();
    }  
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}