import 'package:banquet/Views/Screens/Auth/select_categorey.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Banquet',
          home: CategoreyPage(),
        );
      }));
}
