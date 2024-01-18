import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:wbfactory/components/buttons/main_button.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/views/drawer/drawer_screens/setting_screens/address/verify_address_screen.dart';

import '../../../../../components/textfield/custom_textfield.dart';
import '../../../../../constants/consts.dart';

class AddNewAddressPage extends StatefulWidget {
  const AddNewAddressPage({super.key});

  @override
  State<AddNewAddressPage> createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    titleController.dispose();
    nameController.dispose();
    phoneController.dispose();
    streetController.dispose();
    cityController.dispose();
    zipController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        centerTitle: true,
        title: const Text(
          "Add Address",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: lightColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: lightColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              16.heightBox,
              CustomTextfield(
                controller: titleController,
                hintText: "Home or Work",
                title: "Address Title",
                showTitle: true,
                keyboardType: TextInputType.name,
              ),
              12.heightBox,
              CustomTextfield(
                controller: nameController,
                hintText: "eg. Alex Cary",
                title: "Receiver's Name",
                showTitle: true,
                keyboardType: TextInputType.name,
              ),
              12.heightBox,
              CustomTextfield(
                controller: phoneController,
                hintText: "eg. +1XXXXXXXXXX",
                title: "Receiver's Contact Number",
                showTitle: true,
                keyboardType: TextInputType.phone,
              ),
              12.heightBox,
              CustomTextfield(
                controller: streetController,
                hintText: "eg. 54th Lincoln Street",
                title: "Street Address",
                showTitle: true,
                keyboardType: TextInputType.streetAddress,
              ),
              12.heightBox,
              CustomTextfield(
                controller: cityController,
                hintText: "eg. Brooklyn, NY",
                title: "City and State",
                showTitle: true,
                keyboardType: TextInputType.streetAddress,
              ),
              12.heightBox,
              CustomTextfield(
                controller: zipController,
                hintText: "eg. 10001",
                title: "Zip or Postal Code",
                showTitle: true,
                keyboardType: TextInputType.phone,
              ),
              16.heightBox,
              MainButton(
                title: "Save Address",
                onTap: () {
                  Map<String, String> addressInput = {
                    'title': titleController.text,
                    'name': nameController.text,
                    'phone': phoneController.text,
                    'street': streetController.text,
                    'city': cityController.text,
                    'country': "United States",
                    'zip': zipController.text,
                  };

                  if (titleController.text != "" &&
                      nameController.text != "" &&
                      phoneController.text != "" &&
                      streetController.text != "" &&
                      cityController.text != "" &&
                      zipController.text != "") {
                    Get.to(
                          () => VerifyAddressPage(
                        addressInput: addressInput,
                      ),
                    );
                  } else {
                    customToast("Enter all the fields first.", lightGreyColor, context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
