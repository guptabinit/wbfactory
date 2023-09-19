import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wbfactory/models/order_model.dart' as order_model;

class ShopMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final curUser = FirebaseAuth.instance.currentUser!.uid;

  Future<order_model.Order> getOrderDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('orders').doc(currentUser.uid).get();

    return order_model.Order.fromSnap(snap);
  }

  Future<String> addFavourite({required Map<dynamic, dynamic> product, required String pid}) async {
    String res = "Some error occurred";

    try {
      await _firestore.collection('users').doc(curUser).set({
        'favourite': FieldValue.arrayUnion([
          product,
        ]),
        'favourite_list': FieldValue.arrayUnion([
          pid,
        ]),
      }, SetOptions(merge: true));

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> removeFavourite({required Map<dynamic, dynamic> product, required String pid}) async {
    String res = "Some error occurred";

    try {
      await _firestore.collection('users').doc(curUser).set({
        'favourite': FieldValue.arrayRemove([
          product,
        ]),
        'favourite_list': FieldValue.arrayRemove([
          pid,
        ]),
      }, SetOptions(merge: true));

      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

}
