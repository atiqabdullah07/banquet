// ignore_for_file: must_be_immutable

import 'package:banquet/App%20Constants/constants.dart';

import 'package:banquet/Controllers/customer_controller.dart';
import 'package:banquet/Views/Screens/Customer/Events/customer_food_events.dart';

import 'package:banquet/Views/Screens/Customer/Events/events.dart';

import 'package:banquet/Views/Screens/Customer/Hall%20Details/hall_details.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  final CustomerController _customerController = Get.put(CustomerController());

  final CustomerProfileController _customerProfileController =
      Get.put(CustomerProfileController());

  @override
  void initState() {
    super.initState();
    _customerController.fetchBanquets();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (_customerProfileController.customer.value.name == '' ||
              _customerProfileController.customer.value.name == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
              color: AppColors.primaryColor,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await _customerController.fetchBanquets();
              },
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          onTap: () {},
                          child: _customerProfileController
                                          .customer.value.profilePhoto ==
                                      '' ||
                                  _customerProfileController
                                          .customer.value.profilePhoto ==
                                      null
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
                                  backgroundColor: AppColors.black,
                                  child: CircleAvatar(
                                    radius: 38.r,
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.5),
                                    backgroundImage: NetworkImage(
                                        _customerProfileController
                                            .customer.value.profilePhoto
                                            .toString()),
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
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            _customerProfileController.customer.value.name
                                        .toString()
                                        .length >
                                    10
                                ? '${_customerProfileController.customer.value.name.toString().substring(0, 10)}...'
                                : _customerProfileController.customer.value.name
                                    .toString(),
                            style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
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
                              color:
                                  Colors.grey.withOpacity(0.15), // Shadow color
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
                                          color:
                                              AppColors.black.withOpacity(0.2),
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
                              child: const Center(
                                child: Icon(
                                  Icons.search_rounded,
                                  color: Colors.white,
                                  size: 22,
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
                                    builder: (context) => Events()));
                          }),
                      servicesButton(
                          icon: 'assets/icons/Free Food.png',
                          title: 'Foods',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomerFoodEvents()));
                          }),
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
                  Obx(() => Column(
                        children: List.generate(
                            _customerController.banquets.length, (index) {
                          return hallCards(
                            banquet: _customerController.banquets[index],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HallDetails(
                                    banquet:
                                        _customerController.banquets[index],
                                    customer: _customerProfileController
                                        .customer.value,
                                    index: index,
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      )),
                ],
              )),
            );
          }
        }),
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
              height: 75,
              width: 75,
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
