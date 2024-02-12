import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Padding logoutButton({required VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          const Text(
            'Logout',
            style: TextStyle(color: Colors.red, fontSize: 15),
          ),
          SizedBox(
            width: 5.w,
          ),
          const Icon(
            Icons.logout,
            color: Colors.red,
          ),
        ],
      ),
    ),
  );
}

GestureDetector profileButton(
    {required String title, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 70.h,
      width: 1.sw,
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            subTitleText(title: title),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.black,
            )
          ],
        ),
      ),
    ),
  );
}
