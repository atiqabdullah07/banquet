import 'dart:developer';
import 'dart:io';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Controllers/auth_controller.dart';
import 'package:banquet/Views/Screens/Customer/Bookings/bookings.dart';
import 'package:banquet/Views/Screens/Customer/My%20Profile/edit_customer_profile.dart';

import 'package:banquet/Views/Screens/Customer/My%20Profile/my_profile_widgets.dart';
import 'package:banquet/Views/Screens/Customer/Wishlist/wishlist.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final AuthController authController = Get.put(AuthController());

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
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditCustomerProfile()));
            },
            child: const Text(
              'Edit Profile',
              style: TextStyle(color: AppColors.black),
            ),
          )
        ],
      ),
      body: Padding(
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
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundColor: AppColors.black,
                  child: pickedImage != null
                      ? CircleAvatar(
                          radius: 48.r,
                          backgroundColor: Colors.white,
                          backgroundImage: FileImage(pickedImage!),
                        )
                      : CircleAvatar(
                          radius: 48.r,
                          backgroundColor: Colors.white,
                          backgroundImage: const NetworkImage(
                              "https://abouteball.com/wp-content/uploads/2015/03/photodune-4276142-smiling-portraits-m1.jpg"),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            subTitleText(title: 'Alex Jhons'),
            const Text('alexjhons@gmail.com'),
            height(20),
            profileButton(
                title: 'Wishlist',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Wishlist()));
                }),
            height(10),
            profileButton(
                title: 'Bookings',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyBookings()));
                }),
            height(100),
          ],
        ),
      ),
    );
  }
}
