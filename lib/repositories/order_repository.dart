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
    return querySnapshot.docs
        .map((doc) => MyOrder(
              id: doc.id,
              items: (doc.get('items') as List<dynamic>)
                  .map((item) => Item(
                        itemId: item['itemId'],
                        name: item['name'],
                        price: item['price'],
                        quantity: item['quantity'],
                      ))
                  .toList(),
              total: doc.get('total'),
              address: doc.get('address'),
              contactNo: doc.get('contactNo'),
              customerName: doc.get('customerName'),
              remarks: doc.get('remarks'),
            ))
        .toList();
  }

  Future<MyOrder> getOrderById(String orderId) async {
    DocumentSnapshot doc = await _collection.doc(orderId).get();
    return MyOrder(
        id: doc.id,
        items: (doc.get('items') as List<dynamic>)
            .map((item) => Item(
                  itemId: item['itemId'],
                  name: item['name'],
                  price: item['price'],
                  quantity: item['quantity'],
                ))
            .toList(),
        total: doc.get('total'),
        address: doc.get('address'),
        contactNo: doc.get('contactNo'),
        customerName: doc.get('customerName'),
        remarks: doc.get('remarks'));
  }

  Future<void> updateOrder(MyOrder order) async {
    await _collection.doc(order.id).update({
      'address': order.address,
      'contactNo': order.contactNo,
      'customerName': order.customerName,
      'remarks': order.remarks
    });
  }

  Future<void> deleteOrder(String orderId) async {
    await _collection.doc(orderId).delete();
  }
}
