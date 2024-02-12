import 'package:banquet/App%20Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

String dateTypeConverter({required String date}) {
  DateTime originalDate = DateTime.parse(date);
  String formattedDate = DateFormat('d MMM y').format(originalDate);
  return formattedDate;
}

void easyLoading() {
  EasyLoading.show(
    indicator: const CircularProgressIndicator(
      backgroundColor: AppColors.secondaryColor,
      color: AppColors.primaryColor,
    ),
    maskType: EasyLoadingMaskType.none,
    dismissOnTap: true,
  );
}

Widget height(int height) {
  return SizedBox(
    height: height.h,
  );
}
