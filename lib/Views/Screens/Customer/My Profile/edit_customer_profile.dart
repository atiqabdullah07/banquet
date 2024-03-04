import 'dart:developer';
import 'dart:io';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';

import 'package:banquet/Controllers/customer_controller.dart';
import 'package:banquet/Models/customer_model.dart';

import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditCustomerProfile extends StatefulWidget {
  const EditCustomerProfile({super.key});

  @override
  State<EditCustomerProfile> createState() => _EditCustomerProfileState();
}

class _EditCustomerProfileState extends State<EditCustomerProfile> {
  final CustomerProfileController _customerProfileController =
      Get.put(CustomerProfileController());

  late TextEditingController nameController;
  late TextEditingController emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    var user = _customerProfileController.customer.value;
    nameController = TextEditingController(text: user.name);

    emailController = TextEditingController(text: user.email);

    super.initState();
  }

  File? pickedImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          pickedImage = File(pickedFile.path);
        });
        log('Image picked: ${pickedFile.path}');
      } else {
        log('No image picked.');
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: const Text('Edit Profile'),
          centerTitle: true,
        ),
        body: Obx(() {
          if (_customerProfileController.customer.value.name == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          pickImage();
                        },
                        child: _customerProfileController
                                        .customer.value.profilePhoto ==
                                    '' &&
                                pickedImage == null
                            ? CircleAvatar(
                                radius: 50.r,
                                backgroundColor: AppColors.secondaryColor,
                                child: const Icon(
                                  Icons.person,
                                  size: 50,
                                ),
                              )
                            : CircleAvatar(
                                radius: 50.r,
                                backgroundColor: AppColors.black,
                                child: pickedImage != null
                                    ? CircleAvatar(
                                        radius: 48.r,
                                        backgroundColor: Colors.white,
                                        backgroundImage:
                                            FileImage(pickedImage!),
                                      )
                                    : CircleAvatar(
                                        radius: 48.r,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                          _customerProfileController
                                              .customer.value.profilePhoto
                                              .toString(),
                                        ),
                                      ),
                              ),
                      ),
                    ),
                    height(20),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          subTitleText(title: 'Name'),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: AppColors.black.withOpacity(0.5)),
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter your Name';
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          subTitleText(title: 'Email'),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                            child: TextFormField(
                              enabled: false,
                              controller: emailController,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: AppColors.black.withOpacity(0.5)),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          height(100),
                          Center(
                            child: Column(
                              children: [
                                appButton(
                                  title: 'Save Changes',
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await _customerProfileController
                                          .updateCustomerProfile(
                                              Customer(
                                                  name: nameController.text,
                                                  profilePhoto:
                                                      _customerProfileController
                                                          .customer
                                                          .value
                                                          .profilePhoto),
                                              pickedImage);

                                      await _customerProfileController
                                          .getCustomer();
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }));
  }
}
