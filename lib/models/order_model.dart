import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String uid;
  final String email;
  final String fullName;
  final String mobile;
  final List orders;
  final List unreviewed;
  final List reviews;

  Order({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.mobile,
    required this.orders,
    required this.unreviewed,
    required this.reviews,

  });

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'email' : email,
    'full_name' : fullName,
    'mobile' : mobile,
    'orders' : orders,
    'unreviewed' : unreviewed,
    'reviews' : reviews,
  };

  static Order fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return Order(
      uid: snapshot['uid'],
      email: snapshot['email'],
      fullName: snapshot['fullName'],
      mobile: snapshot['mobile'],
      orders: snapshot['orders'],
      unreviewed: snapshot['unreviewed'],
      reviews: snapshot['reviews'],
    );
  }

}