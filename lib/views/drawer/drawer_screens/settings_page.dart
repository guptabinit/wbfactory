import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:lottie/lottie.dart';
import 'package:wbfactory/views/drawer/drawer_screens/setting_screens/saved_address.dart';
import '../../../components/buttons/back_button.dart';
import '../../../constants/colors.dart';
import '../../../constants/consts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {

    final Uri url = Uri.parse("https://doc-hosting.flycricket.io/teriyaki-bowl-privacy-policy/8e5e969b-ac05-4afe-843b-1d74615ad4a6/privacy");

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
                // showDialog(
                //   context: context,
                //   builder: (ctx) => Dialog(
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8),
                //         color: lightColor,
                //       ),
                //       padding: const EdgeInsets.all(16),
                //       child: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //           const Text(
                //             "Teriyaki Bowl",
                //             style: TextStyle(
                //               fontSize: 28,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //           12.heightBox,
                //           const Text(
                //             "Are you sure you want to delete your account?",
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               fontSize: 14,
                //             ),
                //           ),
                //           16.heightBox,
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               CustomButton(
                //                 btnText: "Yes",
                //                 onTap: () {
                //                   showDialog(
                //                     context: context,
                //                     builder: (ctx) => Dialog(
                //                       shape: RoundedRectangleBorder(
                //                         borderRadius:
                //                         BorderRadius.circular(8),
                //                       ),
                //                       child: Container(
                //                         decoration: BoxDecoration(
                //                           borderRadius:
                //                           BorderRadius.circular(8),
                //                           color: lightColor,
                //                         ),
                //                         padding: const EdgeInsets.all(16),
                //                         child: Column(
                //                           crossAxisAlignment:
                //                           CrossAxisAlignment.stretch,
                //                           mainAxisSize: MainAxisSize.min,
                //                           children: [
                //                             const Text(
                //                               "Teriyaki Bowl",
                //                               textAlign: TextAlign.center,
                //                               style: TextStyle(
                //                                 fontSize: 28,
                //                                 fontWeight: FontWeight.bold,
                //                               ),
                //                             ),
                //                             12.heightBox,
                //                             const Text(
                //                               "Enter your credential",
                //                               textAlign: TextAlign.center,
                //                               style: TextStyle(
                //                                 fontSize: 14,
                //                               ),
                //                             ),
                //                             16.heightBox,
                //                             CustomTextField(
                //                                 controller: emailController,
                //                                 fontWeight: FontWeight.normal,
                //                                 labelText:
                //                                 "Enter your email"),
                //                             8.heightBox,
                //                             CustomTextField(
                //                                 controller:
                //                                 passwordController,
                //                                 fontWeight: FontWeight.normal,
                //                                 isPass: true,
                //                                 labelText:
                //                                 "Enter your password"),
                //                             16.heightBox,
                //                             isLoading
                //                                 ? const Center(
                //                               child:
                //                               CircularProgressIndicator(
                //                                 color: primaryColor,
                //                               ),
                //                             )
                //                                 : Row(
                //                               children: [
                //                                 Expanded(
                //                                   child: CustomButton(
                //                                     btnText:
                //                                     "Delete Account",
                //                                     onTap: () async {
                //                                       setState(() {
                //                                         isLoading =
                //                                         true;
                //                                       });
                //
                //                                       await AuthMethods()
                //                                           .deleteUser(
                //                                         emailController
                //                                             .text,
                //                                         passwordController
                //                                             .text,
                //                                         ctx,
                //                                       );
                //
                //                                       setState(() {
                //                                         emailController
                //                                             .text = "";
                //                                         passwordController
                //                                             .text = "";
                //                                         isLoading =
                //                                         false;
                //                                       });
                //                                     },
                //                                   ),
                //                                 ),
                //                                 8.widthBox,
                //                                 CustomButton(
                //                                   btnText: "Back",
                //                                   onTap: () {
                //                                     setState(() {
                //                                       emailController
                //                                           .text = "";
                //                                       passwordController
                //                                           .text = "";
                //                                     });
                //                                     Get.close(2);
                //                                   },
                //                                 ),
                //                               ],
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                   );
                //                 },
                //               ),
                //               16.widthBox,
                //               CustomButton(
                //                 btnText: "No",
                //                 onTap: () {
                //                   Navigator.of(context).pop();
                //                 },
                //               ),
                //             ],
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // );
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
