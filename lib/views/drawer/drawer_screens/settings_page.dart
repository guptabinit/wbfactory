import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/views/drawer/drawer_screens/setting_screens/change_password_screen.dart';
import 'package:wbfactory/views/drawer/drawer_screens/setting_screens/delete_account_screen.dart';
import 'package:wbfactory/views/drawer/drawer_screens/setting_screens/edit_profile_screen.dart';
import 'package:wbfactory/views/drawer/drawer_screens/setting_screens/saved_address.dart';
import '../../../components/buttons/back_button.dart';
import '../../../constants/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(
        "https://whitestonebagelfactory.com/terms-conditions/");

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
              "Settings",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
            8.heightBox,
            const Text(
              "Here you can take look at all your settings options.",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: darkGreyColor,
              ),
            ),
            12.heightBox,
            GestureDetector(
              onTap: () {
                Get.to(() => const EditProfileScreen());
              },
              child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.edit,
                        color: secondaryColor,
                      ),
                      12.widthBox,
                      const Expanded(
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            12.heightBox,
            GestureDetector(
              onTap: () {
                Get.to(() => const SavedAddressPage());
              },
              child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: secondaryColor,
                      ),
                      12.widthBox,
                      const Expanded(
                        child: Text(
                          "Saved Address",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            12.heightBox,
            GestureDetector(
              onTap: () {
                Get.to(() => const ChangePasswordScreen());
              },
              child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.lock_open_sharp,
                        color: secondaryColor,
                      ),
                      12.widthBox,
                      const Expanded(
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            12.heightBox,
            GestureDetector(
              onTap: () {
                launchUrl(url);
              },
              child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.privacy_tip_outlined,
                        color: secondaryColor,
                      ),
                      12.widthBox,
                      const Expanded(
                        child: Text(
                          "Privacy Policy",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            12.heightBox,
            GestureDetector(
              onTap: () {
                Get.to(() => const DeleteAccountScreen());
              },
              child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete_forever_outlined,
                        color: secondaryColor,
                      ),
                      12.widthBox,
                      const Expanded(
                        child: Text(
                          "Delete Account",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
