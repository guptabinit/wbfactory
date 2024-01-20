import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wbfactory/views/order_screens/order_palaced_screens/new_order_placed_screen.dart';
import 'package:wbfactory/views/order_screens/order_palaced_screens/order_rejected_screen.dart';
import 'package:wbfactory/views/order_screens/order_palaced_screens/order_waiting_screen.dart';

import 'order_palaced_screens/some_error_screen.dart';

class OrderStatusScreen extends StatefulWidget {
  final String oid;
  final bool isPaid;
  const OrderStatusScreen({super.key, required this.oid, required this.isPaid});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {

  bool isError = false;

  @override
  void initState() {
    if(widget.oid == "error"){
      setState(() {
        isError = true;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isError ? SomeErrorScreen() : StreamBuilder(
          stream: FirebaseFirestore.instance.collection('allOrders').where("oid", isEqualTo: widget.oid).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return OrderWaitingScreen(isPaid: widget.isPaid,);
            }

            int fOid = snapshot.data!.docs[0]["order_accepted"];

            if(fOid == 0){
              return OrderWaitingScreen(isPaid: widget.isPaid,);
            } else if (fOid == 1){
              return NewOrderPlacedScreen(isPaid: widget.isPaid,);
            } else {
              return OrderRejectedScreen(isPaid: widget.isPaid,);
            }

          },
      ),
    );
  }
}
