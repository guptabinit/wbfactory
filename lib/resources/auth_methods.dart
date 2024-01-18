import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wbfactory/models/user_model.dart' as user_model;
import 'package:wbfactory/models/order_model.dart' as order_model;
import 'package:wbfactory/views/onboarding_screens/verification_page.dart';

import '../constants/colors.dart';
import '../constants/consts.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<user_model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return user_model.User.fromSnap(snap);
  }

  // register a new user
  Future<String> signUpUser({
    required Map<String, String> data,
  }) async {
    String res = "Some error occurred";

    try {
      if (data['email']!.isNotEmpty ||
          data['phone']!.isNotEmpty ||
          data['full_name']!.isNotEmpty ||
          data['password']!.isNotEmpty ||
          data['password']!.length >= 6) {
        // verify Mobile Number
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: data['email']!, password: data['password']!);

        // add user to the database
        user_model.User user = user_model.User(
          uid: cred.user!.uid,
          email: data['email']!,
          mobile: data['phone']!,
          fullName: data['full_name']!,
          cart: [],
          favourite: [],
          favouriteList: [],
          cartAmount: 0.00,
          totalOrders: 0,
          coins: 0,
          address: [],
          usedCoupons: [],
        );

        order_model.Order order = order_model.Order(
          uid: cred.user!.uid,
          email: data['email']!,
          fullName: data['full_name']!,
          mobile: data['phone']!,
          orders: [],
          unreviewed: [],
          reviews: [],
        );

        // adding user info in database
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        await _firestore
            .collection('orders')
            .doc(cred.user!.uid)
            .set(order.toJson());
        await _firestore.collection('cart').doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'cart_amount': 0,
          'items': [],
        });
        await _firestore.collection('coins').doc(cred.user!.uid).set({
          "uid": cred.user!.uid,
          "coins": 0,
          "cash": 0,
        });

        res = "success";
      } else {
        res = 'Please enter all the details';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // login an existing user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          res = 'success';
        });
      } else {
        res = 'Please enter all the details';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // logging out a signed in user
  Future<String> signOut() async {
    String res = 'Some error occurred';
    try {
      await _auth.signOut();
      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // // verify a phone number *****
  // Future<void> sendVerificationCode({
  //   required String phoneNumber,
  //   required Map<String, String> signUpData,
  //   required context,
  // }) async {
  //
  //   try {
  //     // Start the phone number verification process
  //     await FirebaseAuth.instance.verifyPhoneNumber(
  //       phoneNumber: "+1$phoneNumber",
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         // Automatically handle verification if the user's phone number is instantly verified
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         customToast('verification failed: $e', redColor, context);
  //       },
  //       codeSent: (String verificationId, int? resendToken) {
  //         customToast("Code sent successfully", greenColor, context);
  //         Get.to(
  //           () => VerificationPage(
  //             verificationId: verificationId,
  //             mobileNumber: "+1$phoneNumber",
  //             signUpData: signUpData,
  //           ),
  //         );
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         // Handle code auto-retrieval timeout
  //         // This callback is triggered if the automatic code retrieval process times out
  //         customToast("Retrieval Timeout: $verificationId", redColor, context);
  //       },
  //       timeout: const Duration(seconds: 60), // Timeout duration for the verification process
  //     );
  //   } catch (e) {
  //     customToast('error: $e', redColor, context);
  //   }
  //
  // }

  // Future<String> verifyCode({
  //   required String verificationId,
  //   required String smsCode,
  //   required context,
  // }) async {
  //   String res = 'Some error occurred';
  //   var credential = PhoneAuthProvider.credential(
  //     verificationId: verificationId,
  //     smsCode: smsCode,
  //   );
  //   try {
  //     await _auth.signInWithCredential(credential);
  //
  //     await _auth.signOut();
  //
  //     // customToast("Successfully Login", greenColor, context);
  //
  //     res = 'success';
  //   } catch (e) {
  //     customToast("error: $e", redColor, context);
  //     res = 'error: $e';
  //   }
  //   return res;
  // }

  // Changing Password

  Future<String> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    String res = "Some error occurred";

    var curUser = _auth.currentUser;

    try {
      user_model.User userDetail = await AuthMethods().getUserDetails();

      String email = userDetail.email;

      var cred =
          EmailAuthProvider.credential(email: email, password: oldPassword);

      await curUser!.reauthenticateWithCredential(cred).then((value) async {
        curUser.updatePassword(newPassword);

        res = "success";
      }).catchError((error) {
        res = error.toString();
      });
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // delete account
  Future<String> deleteUser(
      {required String email, required String password, context}) async {
    String res = "Some error occurred";

    try {
      User currentUser = _auth.currentUser!;

      final cred =
          EmailAuthProvider.credential(email: email, password: password);

      var result = await currentUser.reauthenticateWithCredential(cred);

      // called from database class
      await result.user!.delete().then((value) async {
        await _firestore.collection('users').doc(currentUser.uid).delete();
        await _firestore.collection('cart').doc(currentUser.uid).delete();

        res = "success";
      });
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
