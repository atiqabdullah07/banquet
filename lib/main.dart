import 'dart:io';

import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Controller%20Binding/controller_binding.dart';
import 'package:banquet/Views/Screens/Auth/select_categorey.dart';
import 'package:banquet/Views/Screens/Banquet/banquet_home.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isIOS
      ? await Firebase.initializeApp()
      : await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyBrH2YhNvBoMG8afZMovxU1FIJmzvLrO10",
              appId: "1:310762733462:android:d48a51a8385d51f62327b7",
              messagingSenderId: "310762733462",
              storageBucket: "banquet-75822.appspot.com",
              projectId: "banquet-75822"),
        );

  // Ensure screen size and initialize ScreenUtil
  await ScreenUtil.ensureScreenSize();
  runApp(
    ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return GetMaterialApp(
          theme: myTheme(),
          initialBinding: ControllerBinding(),
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          title: 'Banquet',
          home: BanquetHome(),
        );
      },
    ),
  );
}
