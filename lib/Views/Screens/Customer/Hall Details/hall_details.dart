import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:banquet/App%20Constants/constants.dart';
import 'package:banquet/Views/Screens/Customer/Confirm%20Booking/confirm_booking.dart';
import 'package:banquet/Views/Screens/Customer/Hall%20Details/hall_details_widgets.dart';
import 'package:banquet/Views/Widgets/common_widgets.dart';
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
        body: SingleChildScrollView(
          child: Column(
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
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText(title: 'Mehria Marquee'),
                    subTitleText(title: 'Description'),
                    Text(
                      'Come to Mehria Marquee & Events for all your special occasions, For us no event is big or small, Our aim is to make sure its memorable.',
                      style: TextStyle(color: AppColors.black.withOpacity(0.7)),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    subTitleText(title: 'Details'),
                    Row(
                      children: [
                        hallDetailsCard(
                            icon: 'assets/icons/type.png',
                            title: 'Type',
                            value: 'Marquee'),
                        SizedBox(
                          width: 10.w,
                        ),
                        hallDetailsCard(
                            icon: 'assets/icons/parking.png',
                            title: 'Parking',
                            value: '100 Cars'),
                        SizedBox(
                          width: 10.w,
                        ),
                        hallDetailsCard(
                            icon: 'assets/icons/capacity.png',
                            title: 'Capacity',
                            value: '1500'),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        hallDetailsCard(
                            title: 'Booking Price', value: 'Pkr 20000 - 30000'),
                        SizedBox(
                          width: 10.w,
                        ),
                        hallDetailsCard(
                            title: 'Facilties', value: 'Decoration, Studio'),
                        SizedBox(
                          width: 10.w,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    subTitleText(title: 'Menu'),
                    const Menu(),
                    const Menu(),
                    const Menu(),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              appButton(
                  title: 'Continue Booking',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConfirmBooking()));
                  }),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
