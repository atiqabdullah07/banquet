import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Controllers/banquet_controller.dart';
import 'package:banquet/Controllers/customer_controller.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:banquet/Models/customer_model.dart';
import 'package:banquet/Views/Screens/Customer/Confirm%20Booking/confirm_booking.dart';
import 'package:banquet/Views/Screens/Customer/Hall%20Details/hall_details_widgets.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HallDetails extends StatefulWidget {
  const HallDetails(
      {super.key,
      required this.banquet,
      required this.customer,
      required this.index});

  final Banquet banquet;
  final Customer customer;
  final int index;

  @override
  State<HallDetails> createState() => _HallDetailsState();
}

class _HallDetailsState extends State<HallDetails> {
  final BanquetController banquetController = Get.put(BanquetController());
  final CustomerController _customerController = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    var images = const [
      NetworkImage(
          'https://i.pinimg.com/originals/85/7a/bc/857abcdd95af8530c9d022f5cb420932.png'),
      NetworkImage(
          'https://www.arabiaweddings.com/sites/default/files/styles/max980/public/articles/2018/02/sharjah_wedding_halls.jpg?itok=9VGejPRc'),
      NetworkImage(
          'https://www.jaypeehotels.com/blog/wp-content/uploads/2020/07/JGGR-Banquets-1024x699-1.jpg')
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 250.h,
            width: double.infinity,
            child: AnotherCarousel(
              images: images,
              dotBgColor: Colors.transparent,
              dotIncreasedColor: AppColors.primaryColor,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleText(title: widget.banquet.name.toString()),
                subTitleText(title: 'Description'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.banquet.description.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(
                          color: AppColors.black.withOpacity(0.7),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Obx(
                        () {
                          return IconButton(
                            onPressed: () {
                              _customerController.addToWishlist(
                                  id: widget.banquet.uid.toString());
                            },
                            icon: _customerController
                                    .banquets[widget.index].wishlist!
                                    .contains(firebaseAuth.currentUser!.uid)
                                ? const Icon(
                                    Icons.bookmark,
                                    color: Colors.amber,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.bookmark_outline_outlined,
                                    size: 30,
                                  ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                subTitleText(title: 'Details'),
                Row(
                  children: [
                    hallDetailsCard(
                        icon: 'assets/icons/type.png',
                        title: 'Type',
                        value: widget.banquet.venueType.toString()),
                    SizedBox(
                      width: 10.w,
                    ),
                    hallDetailsCard(
                        icon: 'assets/icons/parking.png',
                        title: 'Parking',
                        value: widget.banquet.parkingCapacity.toString()),
                    SizedBox(
                      width: 10.w,
                    ),
                    hallDetailsCard(
                        icon: 'assets/icons/capacity.png',
                        title: 'Capacity',
                        value: widget.banquet.guestsCapacity.toString()),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    hallDetailsCard(
                        title: 'Booking Price',
                        value: widget.banquet.bookingPrice.toString()),
                    SizedBox(
                      width: 10.w,
                    ),
                    hallDetailsCard(
                        title: 'Facilties',
                        value: widget.banquet.facilities.toString()),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                subTitleText(title: 'Menu'),
                widget.banquet.menu!.isEmpty
                    ? const Center(
                        child: Text('No Menu by the Banquet'),
                      )
                    : Column(
                        children: List.generate(
                          widget.banquet.menu!.length,
                          (index) => Menu(
                            menu: widget.banquet.menu![index],
                          ),
                        ),
                      )
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          appButton(
              title: 'Continue Booking',
              onTap: () {
                banquetController.selectedMenu.value = 2000;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmBooking(
                      banquet: widget.banquet,
                      customer: widget.customer,
                    ),
                  ),
                );
              }),
          const SizedBox(
            height: 100,
          )
        ],
      )),
    );
  }
}
