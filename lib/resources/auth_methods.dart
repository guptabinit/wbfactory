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

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();

    return user_model.User.fromSnap(snap);
  }

  // register a new user
  Future<String> signUpUser({
    required String email,
    required String fullName,
    required String mobile,
    required String password,
    required bool isVerified,
  }) async {
    String res = "Some error occurred";

    try {
      if (email.isNotEmpty || fullName.isNotEmpty || mobile.isNotEmpty || password.isNotEmpty || password.length >= 6) {
        // verify Mobile Number
        if (isVerified) {
          // register user
          UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

          // add user to the database
          user_model.User user = user_model.User(
            uid: cred.user!.uid,
            email: email,
            mobile: mobile,
            fullName: fullName,
            cart: [],
            favourite: [],
            favouriteList: [],
            cartAmount: 0.00,
            totalOrders: 0,
            coins: 0,
            address: [],
          );

          order_model.Order order = order_model.Order(
            uid: cred.user!.uid,
            email: email,
            fullName: fullName,
            mobile: mobile,
            orders: [],
            unreviewed: [],
            reviews: [],
          );

          // adding user info in database
          await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());
          await _firestore.collection('orders').doc(cred.user!.uid).set(order.toJson());
          await _firestore.collection('cart').doc(cred.user!.uid).set({
            'uid': cred.user!.uid,
            'cart_amount': 0.00,
            'items': [],
          });

          res = "success";
        } else {
          res = 'Phone number is not verified';
        }
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
        await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
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

  // verify a phone number *****
  Future<String> sendVerificationCode({
    required String phoneNumber,
    required Map<String, String> signUpData,
    required context,
  }) async {
    String res = "Some error occurred";

    try {
      // Start the phone number verification process
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Automatically handle verification if the user's phone number is instantly verified
        },
        verificationFailed: (FirebaseAuthException e) {
          res = 'verification failed: $e';
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Handle code sent to the user's phone
          // You can store the verification ID and resend token if needed
          // For example, you might display a UI to enter the verification code
          // and call `signInWithCredential` using the verification code
          customToast("Code sent successfully", greenColor, context);
          Get.to(
            () => VerificationPage(
              verificationId: verificationId,
              mobileNumber: phoneNumber,
              signUpData: signUpData,
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle code auto-retrieval timeout
          // This callback is triggered if the automatic code retrieval process times out
          res = "Retrieval Timeout: $verificationId";
        },
        timeout: const Duration(seconds: 60), // Timeout duration for the verification process
      );
      res = 'success';
    } catch (e) {
      res = 'error: $e';
    }

    return res;
  }

  Future<String> verifyCode({
    required String verificationId,
    required String smsCode,
    required context,
  }) async {
    String res = 'Some error occurred';
    var credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    try {
      await _auth.signInWithCredential(credential);

      await _auth.signOut();

      // customToast("Successfully Login", greenColor, context);

      res = 'success';
    } catch (e) {
      customToast("error: $e", redColor, context);
      res = 'error: $e';
    }
    return res;
  }
}
