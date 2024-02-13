import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Views/Screens/Customer/Bookings/bookings.dart';
import 'package:banquet/Views/Screens/Customer/My%20Profile/my_profile_widgets.dart';
import 'package:banquet/Views/Screens/Customer/Wishlist/wishlist.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text('Profile'),
        centerTitle: true,
        actions: [logoutButton(onTap: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: CircleAvatar(
              radius: 50.r,
              backgroundColor: AppColors.black,
              child: CircleAvatar(
                radius: 48.r,
                backgroundColor: Colors.green,
                backgroundImage: const NetworkImage(
                    "https://abouteball.com/wp-content/uploads/2015/03/photodune-4276142-smiling-portraits-m1.jpg"),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Wishlist()));
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
        ]),
      ),
    );
  }
}
