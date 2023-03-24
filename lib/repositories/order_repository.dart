import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/order.dart';

class OrderRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('order');

  Future<void> addOrder(MyOrder order) async {
    await _collection.doc(order.id).set({
      "customerName": order.customerName,
      "address": order.address,
      "contactNo": order.contactNo,
      "remarks": order.remarks,
      'items': order.items
          .map((item) => {
                'name': item.name,
                'price': item.price,
                'quantity': item.quantity,
              })
          .toList(),
      'total': order.total,
    });
  }
}
