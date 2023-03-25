import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/menu.dart';

class MenuRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('menu');
  Stream<List<Menu>> getMenu() {
    return _collection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Menu.fromMap(doc)).toList());
  }

  Future<void> addMenu(Menu menu) {
    return _collection.add(menu.toMap());
  }

}
