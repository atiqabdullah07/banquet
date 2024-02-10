import 'package:banquet/Views/Pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return const MaterialApp(
          title: 'Banquet',
          home: Home(),
        );
      }));
}
