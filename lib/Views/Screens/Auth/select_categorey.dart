import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Controllers/banquet_controller.dart';
import 'package:banquet/Models/banquet_model.dart';
import 'package:banquet/Views/Screens/Auth/auth_widgets.dart';
import 'package:banquet/Views/Screens/Auth/login.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoreyPage extends StatefulWidget {
  const CategoreyPage({super.key});

  @override
  State<CategoreyPage> createState() => _CategoreyPageState();
}

class _CategoreyPageState extends State<CategoreyPage> {
  final BanquetController banquetController = Get.put(BanquetController());
  var isSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
          ),
          titleText(title: 'Continue As?'),
          Text(
            "Select a Category to begin.",
            style: TextStyle(
              color: AppColors.black.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 60.h,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              categoreyCard(
                  isSelected: isSelected == 1 ? true : false,
                  image: "assets/customer.png",
                  title: "Customer",
                  onPress: () {
                    setState(() {
                      isSelected = 1;
                    });
                  }),
              SizedBox(
                width: 20.w,
              ),
              categoreyCard(
                  image: "assets/banquet.png",
                  title: "Banquet",
                  isSelected: isSelected == 2 ? true : false,
                  onPress: () {
                    setState(() {
                      isSelected = 2;
                    });
                  })
            ],
          ),
          SizedBox(
            height: 100.h,
          ),
          CustomButton(title: 'test', onPress: () {}),
          CustomButton(
            title: "Lets Get Started",
            nextIcon: true,
            onPress: () {
              //     addDummyData();

              if (isSelected == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login(
                            role: 'customer',
                          )),
                );
              } else if (isSelected == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Login(
                            role: 'banquet',
                          )),
                );
              }
            },
            color: isSelected == 0
                ? AppColors.black.withOpacity(0.5)
                : AppColors.primaryColor,
          )
        ],
      ),
    );
  }
}
