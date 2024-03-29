// ignore_for_file: use_build_context_synchronously

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Controllers/auth_controller.dart';
import 'package:banquet/Controllers/banquet_controller.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:banquet/Views/Screens/Auth/select_categorey.dart';

import 'package:banquet/Views/Screens/Banquet/Booking%20Request/booking_requests.dart';
import 'package:banquet/Views/Screens/Banquet/Events/banquet_events.dart';
import 'package:banquet/Views/Screens/Banquet/Events/food_event.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BanquetDashboard extends StatefulWidget {
  const BanquetDashboard({super.key});

  @override
  State<BanquetDashboard> createState() => _BanquetDashboardState();
}

class _BanquetDashboardState extends State<BanquetDashboard> {
  final BanquetController _banquetController = Get.put(BanquetController());
  final BanquetProfileController _banquetProfileController =
      Get.put(BanquetProfileController());
  final AuthController _authController = Get.put(AuthController());
  Banquet? banquet;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.backgroundColor,
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                ),
                child: Center(
                  child: Text(
                    'Banquet',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      ListTile(
                        title: const Text('Event Posts'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BanquetEvents()));
                        },
                      ),
                      ListTile(
                        title: const Text('Food Posts'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BanquetFoodEvents()));
                        },
                      ),
                      ListTile(
                        title: const Text('Advertisements'),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('History'),
                        onTap: () {},
                      ),
                    ],
                  ),
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
                ],
              )
            ],
          ),
        ),
        body: Obx(() {
          if (_banquetProfileController.myBanquet.value.name == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
              color: AppColors.primaryColor,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await _banquetController.fetchBookings();
              },
              child: SingleChildScrollView(
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
                              IconButton(
                                onPressed: () => _openDrawer(),
                                icon: const Icon(Icons.menu),
                              ),
                              _banquetProfileController.myBanquet.value.logo ==
                                          null ||
                                      _banquetProfileController
                                              .myBanquet.value.logo ==
                                          ''
                                  ? CircleAvatar(
                                      radius: 40.r,
                                      backgroundColor: AppColors.secondaryColor,
                                      child: Icon(
                                        Icons.person,
                                        size: 40.r,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 40.r,
                                      backgroundColor:
                                          AppColors.black.withOpacity(0.5),
                                      child: CircleAvatar(
                                        radius: 38.r,
                                        backgroundColor:
                                            AppColors.black.withOpacity(0.5),
                                        backgroundImage: NetworkImage(
                                          _banquetProfileController
                                              .myBanquet.value.logo
                                              .toString(),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello!",
                                    style: TextStyle(
                                      color: AppColors.black.withOpacity(0.5),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    _banquetProfileController
                                                .myBanquet.value.name
                                                .toString()
                                                .length >
                                            10
                                        ? '${_banquetProfileController.myBanquet.value.name.toString().substring(0, 10)}...'
                                        : _banquetProfileController
                                            .myBanquet.value.name
                                            .toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: AppColors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BookingRequests()));
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
                      _banquetController.bookings.isEmpty
                          ? const Center(
                              child: Text('No Booking'),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  _banquetController.bookings.length, (index) {
                                var booking =
                                    _banquetController.bookings[index];
                                return bookingCard(
                                    bookingPrice: booking.bookingPrice,
                                    menu: booking.menu,
                                    guests: booking.guests,
                                    timeSlot: booking.timeSlot,
                                    date: booking.date);
                              }),
                            ),
                    ],
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}

Widget bookingCard(
    {required String bookingPrice,
    required String menu,
    required String guests,
    required String timeSlot,
    required String date}) {
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
                  bookingsCardCell(
                      title: 'Booking Price', value: 'Rs. $bookingPrice'),
                  bookingsCardCell(title: 'Menu', value: menu),
                  bookingsCardCell(title: 'Guests', value: guests),
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
                    timeSlot,
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
                    date,
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
