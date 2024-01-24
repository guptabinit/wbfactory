import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future<bool> sendNotification({
  required String token,
  required String title,
  required String body,
  Map<String, dynamic>? data,
}) async {
  const postUrl = 'https://fcm.googleapis.com/fcm/send';

  final payload = {
    "to": token,
    "notification": {
      "title": title,
      "body": body,
    },
    if (data != null) 'data': data,
  };

  final headers = {
    'content-type': 'application/json',
    'Authorization':
        'key=AAAA_3Bc6no:APA91bFlC2a0KktiWPWPE-pJew4fb74sPM0z0Vlqua23go9zFAFkmAFhgi5y170niDE3U4YzRIDGess5utuHBwocWRTfjWowhF8GzYVX6mWqBj3hGM2saDaoo9rF_DvNb0T69csZF5_3'
  };

  final response = await http.post(
    Uri.parse(postUrl),
    body: json.encode(payload),
    encoding: Encoding.getByName('utf-8'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<List<String>> getTokens() async {
  final doc = await FirebaseFirestore.instance
      .collection(
        'commons',
      )
      .doc('fcm')
      .get();

  if (doc.exists && doc.data()?.containsKey('tokens') == true) {
    final tokens = doc.data()?['tokens'];
    return tokens.cast<String>().toList();
  }
  return [];
}

Future<void> sendNotifications(String orderId) async {
  var snap = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  final user = snap.data()?["full_name"] ?? 'N/A';

  final tokens = await getTokens();
  for (final token in tokens) {
    if (await sendNotification(
      token: token,
      title: 'New Order Placed',
      body: 'A new order has been placed by $user.',
      data: {'oid': orderId},
    )) {
      print('Notification sent to $token');
    }
  }
}
