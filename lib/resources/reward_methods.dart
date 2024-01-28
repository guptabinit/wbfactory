// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:wbfactory/models/coins.dart';
//
// class RewardMethods {
//   RewardMethods._();
//
//   static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   static Stream<Coins> get coinsStream {
//     String? userId = FirebaseAuth.instance.currentUser?.uid;
//     return _firestore
//         .collection('coins')
//         .doc(userId)
//         .withConverter(
//           fromFirestore: (snapshot, options) {
//             return Coins.fromMap(snapshot.data() ?? {});
//           },
//           toFirestore: (value, options) => value.toMap(),
//         )
//         .snapshots()
//         .map((doc) => doc.data() ?? Coins(cash: 0, coins: 0, uid: userId));
//   }
// }
