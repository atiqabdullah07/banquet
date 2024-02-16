import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/App%20Constants/helper_functions.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BanquetDashboard extends StatelessWidget {
  const BanquetDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      radius: 40.r,
                      backgroundColor: AppColors.black.withOpacity(0.5),
                      child: CircleAvatar(
                        radius: 38.r,
                        backgroundColor: AppColors.black.withOpacity(0.5),
                        backgroundImage: const NetworkImage(
                            "https://abouteball.com/wp-content/uploads/2015/03/photodune-4276142-smiling-portraits-m1.jpg"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
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
                      const Text(
                        "Marquee ",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
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
    );
  }
}

Widget bookingCard() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Container(
      height: 150.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          softShadow(),
        ],
        borderRadius: BorderRadius.circular(20),
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Evening',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '26 Jan 2024',
                    style: TextStyle(fontSize: 14),
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
        style: const TextStyle(
            color: AppColors.black, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      Text(
        value,
        style: const TextStyle(
          color: AppColors.black,
          fontSize: 16,
        ),
      ),
    ],
  );
}
