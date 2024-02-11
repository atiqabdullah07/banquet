import 'package:banquet/App%20Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget incDecButton({required IconData icon, required VoidCallback ontap}) {
  return GestureDetector(
    onTap: ontap,
    child: CircleAvatar(
      radius: 20.r,
      backgroundColor: AppColors.secondaryColor,
      child: Center(
        child: Icon(
          icon,
          color: AppColors.primaryColor,
        ),
      ),
    ),
  );
}
