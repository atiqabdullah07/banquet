import 'package:banquet/App%20Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget titleText({required String title}) {
  return Text(
    title,
    style: const TextStyle(
        fontSize: 25, fontWeight: FontWeight.w600, color: AppColors.black),
  );
}

Widget subTitleText({required String title}) {
  return Text(
    title,
    style: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.black),
  );
}

Widget appButton({required String title, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 50.h,
      width: 200.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
          child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
      )),
    ),
  );
}
