import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:restaurant_management/model/itemList.dart';

class MyOrder {
  String id;
  List<Item> items;
  int total;
  String? customerName;
  String? address;
  String? contactNo;
  String? remarks;

  MyOrder(
      {required this.id,
      required this.items, required this.total,
      required this.customerName,
      required this.address,
      required this.contactNo,
      required this.remarks});

  // Map<String, dynamic> toMap() {
  //   return {
  //     'items': items,
  //     'total': total,
  //     'customerName': customerName,
  //     'address': address,
  //     'contactNo': contactNo,
  //     'remarks': remarks
  //   };
  // }

  // factory Order.fromMap(DocumentSnapshot data) {
  //   return Order(
  //       id: data.id,
  //       items: data['items'],
  //       total: data['total'],
  //       customerName: data['customerName'],
  //       address: data['address'],
  //       contactNo: data['contactNo'],
  //       remarks: data['remarks'],
  //       );
  // }
}
