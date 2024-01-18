import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants/colors.dart';

class AddressCard extends StatefulWidget {
  final dynamic snap;
  const AddressCard({super.key, required this.snap});

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lightColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0, 1),
            blurRadius: 1,
            spreadRadius: 2,
          )
        ],
      ),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 16),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.snap['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              6.widthBox,
              Expanded(child: Container()),
              TextButton(
                onPressed: () {
                  // Get.to(() => ViewAddressPage(snap: widget.snap));
                },
                child: const Text("View"),
              ),
            ],
          ),
          Text(
            "${widget.snap['street']}, ${widget.snap['city']}, ${widget.snap['country']} - ${widget.snap['zip']}",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          8.heightBox,
          Row(
            children: [
              Text(
                widget.snap['name'],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
              6.widthBox,
              Expanded(child: Container()),
              Text(
                widget.snap['phone'],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
