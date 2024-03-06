// ignore_for_file: use_build_context_synchronously

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Controllers/auth_controller.dart';
import 'package:banquet/Controllers/customer_controller.dart';
import 'package:banquet/Views/Screens/Auth/select_categorey.dart';
import 'package:banquet/Views/Screens/Customer/Bookings/bookings.dart';
import 'package:banquet/Views/Screens/Customer/My%20Profile/edit_customer_profile.dart';

import 'package:banquet/Views/Screens/Customer/My%20Profile/my_profile_widgets.dart';
import 'package:banquet/Views/Screens/Customer/Wishlist/wishlist.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final CustomerProfileController _customerProfileController =
      Get.put(CustomerProfileController());

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () async {
                var isLogOut = await _authController.signOut();
                if (isLogOut == true) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const CategoreyPage()),
                  );
                }
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  Text(
                    'Log Out',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            const Text('Profile'),
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
        centerTitle: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child:
                      _customerProfileController.customer.value.profilePhoto ==
                                  '' ||
                              _customerProfileController
                                      .customer.value.profilePhoto ==
                                  null
                          ? CircleAvatar(
                              radius: 50.r,
                              backgroundColor: AppColors.secondaryColor,
                              child: Icon(
                                Icons.person,
                                size: 40.r,
                              ),
                            )
                          : CircleAvatar(
                              radius: 50.r,
                              backgroundColor: AppColors.black,
                              child: CircleAvatar(
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
                SizedBox(
                  height: 5.h,
                ),
                subTitleText(
                    title: _customerProfileController.customer.value.name
                        .toString()),
                Text(
                    _customerProfileController.customer.value.email.toString()),
                height(20),
                profileButton(
                    title: 'Wishlist',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Wishlist()));
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
      }),
    );
  }
}
