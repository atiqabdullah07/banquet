import 'package:banquet/App%20Constants/constants.dart';
import 'package:flutter/material.dart';

Widget titleText({required String title}) {
  return Text(
    title,
    style: const TextStyle(
        fontSize: 25, fontWeight: FontWeight.w600, color: AppColors.black),
  );
}
