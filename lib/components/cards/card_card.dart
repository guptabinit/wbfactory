import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/constants/consts.dart';

import '../../constants/colors.dart';
import '../../resources/shop_methods.dart';

class CartCard extends StatefulWidget {
  final dynamic itemSnap;
  final dynamic snap;

  const CartCard({super.key, this.itemSnap, this.snap});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: lightColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      height: 100,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: CachedNetworkImage(
                          key: UniqueKey(),
                          imageUrl: widget.itemSnap['item_image'],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  12.widthBox,
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.itemSnap["item_name"],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: darkColor,
                                ),
                              ),
                              4.heightBox,
                              Text(
                                widget.itemSnap["category"],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: darkGreyColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "\$ ${widget.itemSnap["total_price"].toDouble().toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: darkColor,
                                ),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: reduceCart,
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: secondaryColor,
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    color: lightColor,
                                  ),
                                ),
                              ),
                              12.widthBox,
                              Text(
                                "${widget.itemSnap["quantity"]}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: darkColor,
                                ),
                              ),
                              12.widthBox,
                              GestureDetector(
                                onTap: addCart,
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: secondaryColor,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: lightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              6.heightBox,
              Text(
                widget.itemSnap["isQuantity"] ? "Choice: ${widget.itemSnap["selectedQuantity"]} (\$ ${widget.itemSnap["selectedQuantityPrice"].toDouble().toStringAsFixed(2)})" : "Choice: No Choices Chosen.",
                style: const TextStyle(
                  color: darkGreyColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
              widget.itemSnap['selectedVarient'].length == 0
                  ? Container()
                  : 4.heightBox,
              widget.itemSnap['selectedVarient'].length == 0
                  ? Container()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Variants: ",
                          style: TextStyle(
                            color: darkGreyColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.itemSnap['selectedVarient'].length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              return Text(
                                "${widget.itemSnap['selectedVarient'][index]} : +\$${widget.itemSnap['selectedVarientPrice'][index].toStringAsFixed(2)}, ",
                                style: const TextStyle(
                                  color: darkGreyColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
              widget.itemSnap['specialInstruction'] == ""
                  ? Container()
                  : 4.heightBox,
              widget.itemSnap['specialInstruction'] == ""
                  ? Container()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sp. Instruction: ",
                          style: TextStyle(
                            color: darkGreyColor,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${widget.itemSnap['specialInstruction']}",
                            style: const TextStyle(
                              color: darkGreyColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
        Container(
          color: lightGreyColor,
          height: 1,
        )
      ],
    );
  }

  void reduceCart() async {
    int quantity = widget.itemSnap['quantity'] - 1;
    double totalPrice = quantity.toDouble() * double.parse(widget.itemSnap['package_price'].toDouble().toStringAsFixed(2));
    double cartAmount = widget.snap['cart_amount'] - double.parse(widget.itemSnap['package_price'].toDouble().toStringAsFixed(2));

    if (widget.itemSnap['quantity'] > 1) {
      String message = await ShopMethods().updateCart(
        cartAmount: double.parse(cartAmount.toDouble().toStringAsFixed(2)),
        pid: widget.itemSnap['pid'],
        itemName: widget.itemSnap['item_name'],
        quantity: quantity,
        itemPrice: widget.itemSnap['item_price'],
        packagePrice: widget.itemSnap['package_price'],
        totalPrice: totalPrice,
        itemImage: widget.itemSnap['item_image'],
        context: context,
        selectedVarient: widget.itemSnap['selectedVarient'],
        selectedVarientPrice: widget.itemSnap['selectedVarientPrice'],
        category: widget.itemSnap['category'],
        haveVarient: widget.itemSnap['haveVarient'],
        isQuantity: widget.itemSnap['isQuantity'],
        selectedQuantity: widget.itemSnap['selectedQuantity'],
        selectedQuantityPrice: widget.itemSnap['selectedQuantityPrice'],
        specialInstruction: widget.itemSnap['specialInstruction'],
      );

      if (message == 'success') {
        setState(() {});
      } else {
        showCustomToast("Error: $message", darkGreyColor);
      }
    } else {
      String message = await ShopMethods().deleteCart(
        cartAmount: cartAmount,
        context: context,
        pid: widget.itemSnap['pid'],
      );

      if (message == 'success') {
        setState(() {});
      } else {
        showCustomToast("Error: $message", darkGreyColor);
      }
    }
  }

  showCustomToast(String msg, Color color) {
    return customToast(msg, color, context);
  }

  void addCart() async {
    int quantity = widget.itemSnap['quantity'] + 1;
    double totalPrice = quantity.toDouble() * double.parse(widget.itemSnap['package_price'].toDouble().toStringAsFixed(2));
    double cartAmount = widget.snap['cart_amount'] + double.parse(widget.itemSnap['package_price'].toDouble().toStringAsFixed(2));

    String message = await ShopMethods().updateCart(
      cartAmount: double.parse(cartAmount.toDouble().toStringAsFixed(2)),
      pid: widget.itemSnap['pid'],
      itemName: widget.itemSnap['item_name'],
      quantity: quantity,
      itemPrice: widget.itemSnap['item_price'],
      packagePrice: widget.itemSnap['package_price'],
      totalPrice: totalPrice,
      itemImage: widget.itemSnap['item_image'],
      context: context,
      selectedVarient: widget.itemSnap['selectedVarient'],
      selectedVarientPrice: widget.itemSnap['selectedVarientPrice'],
      category: widget.itemSnap['category'],
      haveVarient: widget.itemSnap['haveVarient'],
      isQuantity: widget.itemSnap['isQuantity'],
      selectedQuantity: widget.itemSnap['selectedQuantity'],
      selectedQuantityPrice: widget.itemSnap['selectedQuantityPrice'],
      specialInstruction: widget.itemSnap['specialInstruction'],
    );

    if (message == 'success') {
      setState(() {});
    } else {
      showCustomToast("Error: $message", darkGreyColor);
    }
  }
}
