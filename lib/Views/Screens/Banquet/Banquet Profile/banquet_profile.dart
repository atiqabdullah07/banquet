import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Controllers/banquet_controller.dart';
import 'package:banquet/Views/Screens/Banquet/Banquet%20Menus/banquet_menus.dart';
import 'package:banquet/Views/Screens/Banquet/Setup%20Profile/setup_profile01.dart';

import 'package:banquet/Views/Screens/Customer/Hall%20Details/hall_details_widgets.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BanquetProfile extends StatefulWidget {
  BanquetProfile({
    super.key,
  });

  final BanquetProfileController _banquetProfileController =
      Get.put(BanquetProfileController());

  @override
  State<BanquetProfile> createState() => _BanquetProfileState();
}

class _BanquetProfileState extends State<BanquetProfile> {
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(child: Obx(() {
        var banquet = widget._banquetProfileController.myBanquet.value;
        return Column(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 40.r,
                        backgroundColor: AppColors.black.withOpacity(0.5),
                        child: banquet.logo == null || banquet.logo == ''
                            ? CircleAvatar(
                                radius: 40.r,
                                backgroundColor: AppColors.secondaryColor,
                                child: Icon(
                                  Icons.person,
                                  size: 40.r,
                                ),
                              )
                            : CircleAvatar(
                                radius: 38.r,
                                backgroundColor:
                                    AppColors.black.withOpacity(0.5),
                                backgroundImage: NetworkImage(
                                  banquet.logo.toString(),
                                ),
                              ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SetupProfile01()));
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Edit Profile',
                              style: TextStyle(
                                  fontSize: 16, color: AppColors.primaryColor),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  titleText(title: banquet.name.toString()),
                  subTitleText(title: 'Description'),
                  Text(
                    banquet.description.toString(),
                    style: TextStyle(color: AppColors.black.withOpacity(0.7)),
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
                          value: banquet.venueType.toString()),
                      SizedBox(
                        width: 10.w,
                      ),
                      hallDetailsCard(
                          icon: 'assets/icons/parking.png',
                          title: 'Parking',
                          value: banquet.parkingCapacity.toString()),
                      SizedBox(
                        width: 10.w,
                      ),
                      hallDetailsCard(
                          icon: 'assets/icons/capacity.png',
                          title: 'Capacity',
                          value: banquet.guestsCapacity.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      hallDetailsCard(
                          title: 'Booking Price',
                          value: banquet.bookingPrice.toString()),
                      SizedBox(
                        width: 10.w,
                      ),
                      hallDetailsCard(
                          title: 'Facilties',
                          value: banquet.facilities.toString()),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subTitleText(title: 'Menu'),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddMenu()));
                        },
                        child: const Text(
                          '+ Add New',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  banquet.menu!.isEmpty
                      ? const Center(
                          child: Text('No Menu by the Banquet'),
                        )
                      : Column(
                          children: List.generate(
                            banquet.menu!.length,
                            (index) => Menu(
                              menu: banquet.menu![index],
                            ),
                          ),
                        )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            const SizedBox(
              height: 100,
            )
          ],
        );
      })),
    );
  }
}
