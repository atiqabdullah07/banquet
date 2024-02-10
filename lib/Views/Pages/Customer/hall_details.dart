import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:banquet/App%20Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HallDetails extends StatelessWidget {
  const HallDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var images = const [
      NetworkImage(
          'https://i.pinimg.com/originals/85/7a/bc/857abcdd95af8530c9d022f5cb420932.png'),
      NetworkImage(
          'https://www.arabiaweddings.com/sites/default/files/styles/max980/public/articles/2018/02/sharjah_wedding_halls.jpg?itok=9VGejPRc'),
      NetworkImage(
          'https://as2.ftcdn.net/v2/jpg/04/20/23/09/1000_F_420230923_agogDJLHbUh7mkM9JycKwPjfpJWBcjd2.jpg')
    ];
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 250.h,
              width: double.infinity,
              child: AnotherCarousel(
                images: images,
                dotBgColor: Colors.transparent,
                dotIncreasedColor: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
