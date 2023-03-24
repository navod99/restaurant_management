import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_management/model/itemList.dart';
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
                'itemId': item.itemId,
                'name': item.name,
                'price': item.price,
                'quantity': item.quantity,
              })
          .toList(),
      'total': order.total,
    });
  }

    Future<List<MyOrder>> getAllOrders() async {
    QuerySnapshot querySnapshot = await _collection.get();
    return querySnapshot.docs.map((doc) => MyOrder(
      id: doc.id,
      items: (doc.get('items') as List<dynamic>).map((item) => Item(
        itemId: item['itemId'],
        name: item['name'],
        price: item['price'],
        quantity: item['quantity'],
      )).toList(),
      total: doc.get('total'), 
      address: doc.get('address'),
      contactNo: doc.get('contactNo'),
      customerName: doc.get('customerName'),
      remarks: doc.get('remarks'),
    )).toList();
  }

  // Future<void> updateOrder(Order order) async {
  //   await ordersRef.doc(order.id).update({
  //     'items': order.items.map((item) => {
  //       'name': item.name,
  //       'price': item.price,
  //       'quantity': item.quantity,
  //     }).toList(),
  //     'total': order.total,
  //   });
  // }

  Future<void> deleteOrder(String orderId) async {
    await _collection.doc(orderId).delete();
  }
}
