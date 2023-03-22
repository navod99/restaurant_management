import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';

class UserRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('user');
  Stream<List<RegisterUser>> getUser() {
    return _collection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => RegisterUser.fromMap(doc)).toList());
  }

  Future<void> addUser(RegisterUser user) {
    return _collection.add(user.toMap());
  }

}
