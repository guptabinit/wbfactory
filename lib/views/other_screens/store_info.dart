import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/other_screens/store_location.dart';

import '../../components/buttons/back_button.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final Uri webUrl = Uri.parse("https://whitestonebagelfactory.com/");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: backButton(
          onTap: () {
            Get.back();
          },
        ),
        leadingWidth: 90,
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Get.offAll(() => const NavScreen());
        //     },
        //     icon: const Icon(
        //       Icons.home_filled,
        //       color: secondaryColor,
        //     ),
        //   ),
        //   8.widthBox,
        // ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          16.heightBox,
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(8),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: darkColor,
                ),
                child: Image.asset("assets/images/blue_logo.webp"),
              ),
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: darkColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      fontSize: 28,
                    ),
                    children: [
                      TextSpan(
                        text: "Whitestone Bagel Factory",
                        style: TextStyle(color: darkColor),
                      ),
                      TextSpan(
                        text: "\nOld Fashion Water Boiled Bagels. Est.1997",
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w400,
                          height: 1.8,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          16.heightBox,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            height: 48,
            child: OutlinedButton(
              onPressed: () {
                Get.to(() => const StoreLocation());
              },
              child: const Text("Get Location"),
            ),
          ),
          8.heightBox,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                launchUrl(Uri.parse("tel://+17187627700"));
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(secondaryColor),
              ),
              child: const Text(
                "Call Us",
                style: TextStyle(color: lightColor),
              ),
            ),
          ),
          16.heightBox,
          const Divider(
            color: darkGreyColor,
          ),
          8.heightBox,
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Contact Details",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: darkColor),
                        ),
                        6.heightBox,
                        Container(
                          height: 4,
                          width: 42,
                          color: primaryColor,
                        )
                      ],
                    ),
                    12.heightBox,
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Address:  ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: SelectableText(
                            "24-17 149th St, Whitestone, NY 11357, USA",
                            style: TextStyle(fontSize: 16, color: darkColor),
                          ),
                        ),
                      ],
                    ),
                    12.heightBox,
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Number:  ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: SelectableText(
                            "+1 (718) 762-7700",
                            style: TextStyle(fontSize: 16, color: darkColor),
                          ),
                        ),
                      ],
                    ),
                    12.heightBox,
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Store Hours:  ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: SelectableText(
                            "Open 7 days a Week\n06:00am ~ 01:00pm",
                            style: TextStyle(fontSize: 16, color: darkColor),
                          ),
                        ),
                      ],
                    ),
                    12.heightBox,
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Website:  ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: SelectableText(
                            "www.whitestonebagelfactory.com",
                            style:
                                TextStyle(fontSize: 16, color: secondaryColor),
                          ),
                        ),
                      ],
                    ),
                    20.heightBox,
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          await launchUrl(webUrl);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(secondaryColor),
                        ),
                        child: const Text(
                          "Visit our website",
                          style: TextStyle(color: lightColor),
                        ),
                      ),
                    ),
                    42.heightBox,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
