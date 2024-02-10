import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AppColors {
  static const primaryColor = Color(0xFF946946);
  static const secondaryColor = Color(0xFFF2E3D4);
  static const backgroundColor = Color(0xFFFCFCFC);
  static const black = Color(0xFF454545);
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
