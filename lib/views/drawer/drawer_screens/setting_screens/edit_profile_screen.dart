import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../components/buttons/back_button.dart';
import '../../../../components/buttons/main_button.dart';
import '../../../../components/cards/address_card.dart';
import '../../../../components/textfield/custom_textfield.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/consts.dart';
import 'address/add_address_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
            8.heightBox,
            const Text(
              "Here you can take edit your information.",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: darkGreyColor,
              ),
            ),
            8.heightBox,
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  if (snapshot.hasData) {
                    var snap = snapshot.data!;
                    nameController.text = snap['full_name'];
                    phoneController.text = snap['mobile'];
                    emailController.text = snap['email'];

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          16.heightBox,
                          CustomTextfield(
                            controller: nameController,
                            hintText: "eg. Alex",
                            title: "Full Name",
                            showTitle: true,
                            keyboardType: TextInputType.name,
                          ),
                          12.heightBox,
                          CustomTextfield(
                            controller: phoneController,
                            hintText: "eg. +1XXXXXXXXXX",
                            title: "Mobile Number",
                            showTitle: true,
                            keyboardType: TextInputType.name,
                          ),
                          12.heightBox,
                          CustomTextfield(
                            controller: emailController,
                            hintText: "eg. name@xyz.com",
                            title: "Email Address",
                            showTitle: true,
                            keyboardType: TextInputType.phone,
                          ),
                          16.heightBox,
                          MainButton(
                            title: "Save Changes",
                            onTap: () {
                              if (emailController.text != "" &&
                                  nameController.text != "" &&
                                  phoneController.text != "") {
                                // do-something
                              } else {
                                customToast("Enter all the fields first.",
                                    redColor, context);
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: secondaryColor,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
