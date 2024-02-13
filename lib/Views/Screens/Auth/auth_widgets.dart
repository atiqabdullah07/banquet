import 'package:banquet/App%20Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget categoreyCard(
    {required String image,
    required String title,
    required bool isSelected,
    required VoidCallback onPress}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: GestureDetector(
      onTap: onPress,
      child: Container(
        height: 150.h,
        width: 1.sw,
        decoration: BoxDecoration(
          color: isSelected == true
              ? AppColors.secondaryColor.withOpacity(0.2)
              : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
              color:
                  isSelected == true ? AppColors.primaryColor : Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 25,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Image.asset(
                  image,
                  height: 120.h,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: isSelected == true
                          ? AppColors.primaryColor
                          : AppColors.black),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
