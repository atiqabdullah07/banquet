import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Controllers/banquet_controller.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:banquet/Views/Screens/Banquet/Banquet%20Profile/banquet_profile.dart';
import 'package:banquet/Views/Screens/Banquet/Booking%20Request/booking_requests.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BanquetDashboard extends StatefulWidget {
  BanquetDashboard({super.key});

  @override
  State<BanquetDashboard> createState() => _BanquetDashboardState();
}

class _BanquetDashboardState extends State<BanquetDashboard> {
  final BanquetController _banquetController = Get.put(BanquetController());
  final BanquetProfileController _banquetProfileController =
      Get.put(BanquetProfileController());
  Banquet? banquet;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: ElevatedButton(
            child: Text('Test'),
            onPressed: () {
              _banquetProfileController.getAuthenticatedUserBanquetInfo();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BanquetProfile()));
                          },
                          child: CircleAvatar(
                            radius: 40.r,
                            backgroundColor: AppColors.black.withOpacity(0.5),
                            child: CircleAvatar(
                              radius: 38.r,
                              backgroundColor: AppColors.black.withOpacity(0.5),
                              backgroundImage: const NetworkImage(
                                  "https://images-platform.99static.com/8o4gbZyhGRrmCBJKnX4GlKZ-9EA=/265x41:1552x1328/500x500/top/smart/99designs-contests-attachments/91/91413/attachment_91413639"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Obx(
                          () => _banquetProfileController.banquetname == ''
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Hello!",
                                      style: TextStyle(
                                        color: AppColors.black.withOpacity(0.5),
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      _banquetProfileController
                                          .myBanquet.value.name
                                          .toString(),
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BookingRequests()));
                        },
                        icon: const Icon(
                          Icons.notifications_outlined,
                          size: 30,
                        ))
                  ],
                ),
                height(20),
                titleText(title: 'My Bookings'),
                height(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(2, (index) {
                    return bookingCard();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget bookingCard() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Container(
      height: 170.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          softShadow(),
        ],
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  bookingsCardCell(title: 'Booking Price', value: 'Rs. 20000'),
                  bookingsCardCell(title: 'Menu', value: 'Menu 01'),
                  bookingsCardCell(title: 'Guests', value: '200'),
                ],
              ),
            ),
            Divider(
              color: AppColors.black.withOpacity(0.1),
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Evening',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.r),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '26 Jan 2024',
                    style: TextStyle(fontSize: 14.r),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Row bookingsCardCell({required String title, required String value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
            color: AppColors.black,
            fontSize: 16.r,
            fontWeight: FontWeight.w600),
      ),
      Text(
        value,
        style: TextStyle(
          color: AppColors.black,
          fontSize: 16.r,
        ),
      ),
    ],
  );
}
