// ignore_for_file: unused_field, unnecessary_null_comparison, use_build_context_synchronously

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Controllers/banquet_controller.dart';
import 'package:banquet/Views/Screens/Chats/chat_screen.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookingRequests extends StatefulWidget {
  BookingRequests({super.key});

  @override
  State<BookingRequests> createState() => _BookingRequestsState();
}

class _BookingRequestsState extends State<BookingRequests> {
  final BanquetController _banquetController = Get.put(BanquetController());

  final BanquetProfileController _banquetProfileController =
      Get.put(BanquetProfileController());

  @override
  void initState() {
    super.initState();
    _banquetController.fetchBookingRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Requests'),
      ),
      body: Obx(() {
        if (_banquetController.isRequestFetched.value == false) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (_banquetController.bookingRequests.isEmpty) {
          return const Center(
            child: Text('No Booking Requests'),
          );
        } else {
          return RefreshIndicator(
            backgroundColor: AppColors.backgroundColor,
            color: AppColors.primaryColor,
            onRefresh: () async {
              await _banquetController.fetchBookingRequests();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: _banquetController.bookingRequests.length,
                itemBuilder: (context, index) {
                  var request = _banquetController.bookingRequests[index];
                  return bookingRequestCard(
                      bookingPrice: request.bookingPrice,
                      menu: request.menu,
                      customerPic: request.customer.profilePhoto.toString(),
                      guests: request.guests,
                      timeSlot: request.timeSlot,
                      date: request.date,
                      customerName: request.customer.name!,
                      onAccept: () async {
                        bool isAccepted =
                            await _banquetController.acceptBooking(request.uid);

                        if (isAccepted == true) {
                          showDialog(
                            context: context,
                            builder: (context) => CustomDialogWidget(
                                title: 'Request Accepted',
                                message: 'Booking Request has been Accepted'),
                          );
                        }
                      },
                      onDecline: () {},
                      onMessageButtonTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatsScreen(
                                      receiverID: request.customer.uid!,
                                      receiverEmail: request.customer.email!,
                                      username: request.customer.name!,
                                    )));
                      });
                },
              ),
            ),
          );
        }
      }),
    );
  }
}

Widget bookingRequestCard({
  required VoidCallback onAccept,
  required VoidCallback onDecline,
  required String customerName,
  required String customerPic,
  required String bookingPrice,
  required String menu,
  required String guests,
  required String timeSlot,
  required String date,
  required VoidCallback onMessageButtonTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Container(
      height: 270.h,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    customerPic == '' || customerName == null
                        ? CircleAvatar(
                            radius: 20.r,
                            backgroundColor: AppColors.secondaryColor,
                            child: const Icon(Icons.person),
                          )
                        : CircleAvatar(
                            radius: 20.r,
                            backgroundColor: AppColors.secondaryColor,
                            backgroundImage:
                                NetworkImage(customerPic.toString()),
                          ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      customerName,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: onMessageButtonTap,
                    icon: const Icon(
                      Icons.chat,
                      color: AppColors.primaryColor,
                    ))
              ],
            ),
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
            ),
            height(20),
            Row(
              children: [
                GestureDetector(
                  onTap: onDecline,
                  child: Container(
                    height: 40.h,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Center(
                        child: Text(
                      'Decline',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: onAccept,
                    child: Container(
                      height: 40.h,
                      width: 130,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Center(
                          child: Text(
                        'Accept',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
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
