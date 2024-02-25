import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Controllers/banquet_controller.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:banquet/Views/Screens/Customer/Events/events.dart';

import 'package:banquet/Views/Screens/Customer/Hall%20Details/hall_details.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDashboard extends StatefulWidget {
  CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  final BanquetController banquetController = Get.put(BanquetController());

  @override
  void initState() {
    super.initState();
    banquetController.fetchBanquets();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 40.r,
                        backgroundColor: AppColors.black,
                        child: CircleAvatar(
                          radius: 38.r,
                          backgroundColor: Colors.green,
                          backgroundImage: const NetworkImage(
                              "https://abouteball.com/wp-content/uploads/2015/03/photodune-4276142-smiling-portraits-m1.jpg"),
                        ),
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
                        "Alex Jhons",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15), // Shadow color
                          spreadRadius: 0, // Spread radius
                          blurRadius: 20, // Blur radius
                          offset: const Offset(
                              0, 0), // Offset in x and y directions
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
                            child: TextField(
                              readOnly: true,
                              onTap: () {},
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: AppColors.black.withOpacity(0.2),
                                      fontSize: 16),
                                  hintText: "Search Banquet..."),
                            ),
                          ),
                        ),
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                              size: 22.r,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Container(
                          width: 220,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                'assets/1.png',
                              ),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Row(
                  children: [
                    titleText(title: 'Services'),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  servicesButton(
                      icon: 'assets/icons/events.png',
                      title: 'Events',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Events()));
                      }),
                  servicesButton(
                      icon: 'assets/icons/Free Food.png',
                      title: 'Foods',
                      onTap: () {}),
                  servicesButton(
                      icon: 'assets/icons/Recomendations.png',
                      title: 'Recomendations',
                      onTap: () {}),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Row(
                  children: [titleText(title: 'Popular Halls')],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),

              // Column(
              //   children: List.generate(
              //       3,
              //       (index) => hallCards(onTap: () {
              //             Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => const HallDetails()));
              //           })),
              // )
              Obx(
                () => SizedBox(
                  height: 1.sh / 2,
                  child: ListView.builder(
                    itemCount: banquetController.banquets.length,
                    itemBuilder: (context, index) {
                      return hallCards(onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HallDetails()));
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding servicesButton(
      {required String icon,
      required String title,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 75.h,
              width: 75.w,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(icon)),
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 15, color: AppColors.black),
          )
        ],
      ),
    );
  }
}
