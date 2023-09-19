import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String fullName;
  final String mobile;
  final List cart;
  final List favourite;
  final List favouriteList;
  final double cartAmount;
  final int totalOrders;
  final int coins;

  User({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.mobile,
    required this.cart,
    required this.favourite,
    required this.favouriteList,
    required this.cartAmount,
    required this.totalOrders,
    required this.coins,
  });

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'email' : email,
    'full_name' : fullName,
    'mobile' : mobile,
    'cart' : cart,
    'favourite' : favourite,
    'favourite_list' : favouriteList,
    'cart_amount' : cartAmount,
    'total_orders' : totalOrders,
    'coins' : coins,
  };

  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot['uid'],
      email: snapshot['email'],
      fullName: snapshot['full_name'],
      mobile: snapshot['mobile'],
      cart: snapshot['cart'],
      favourite: snapshot['favourite'],
      favouriteList: snapshot['favourite_list'],
      cartAmount: snapshot['cart_amount'],
      totalOrders: snapshot['total_orders'],
      coins: snapshot['coins'],
    );
  }

}